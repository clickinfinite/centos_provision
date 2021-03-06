require 'spec_helper'

RSpec.describe 'add-site.sh' do
  include_context 'run script in tmp dir'
  include_context 'build subject'

  let(:script_name) { 'add-site.sh' }
  let(:all_command_stubs) { {nginx: '/bin/true'} }
  let(:nginx_conf) {
    <<-END
      root /var/www/keitaro;

      fastcgi_pass unix:/var/run/php70-fpm.sock;
    END
  }

  let(:make_proper_nginx_conf) do
    [
      'mkdir -p /etc/nginx/conf.d',
      %Q{echo -e "#{nginx_conf}"> /etc/nginx/conf.d/vhosts.conf}
    ]
  end

  let(:make_keitaro_root_dir) { ['mkdir -p /var/www/keitaro'] }

  let(:make_site_root_dir) { ['mkdir -p /var/www/example.com'] }

  let(:prompts) do
    {
      en: {
        site_domains: 'Please enter domain name with aliases, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld)',
        site_root: 'Please enter site root directory',
      },
      ru: {
        site_domains: 'Укажите доменное имя и список альясов через запятую без пробелов (например domain1.tld,www.domain1.tld)',
        site_root: 'Укажите корневую директорию сайта',
      }
    }
  end

  let(:user_values) do
    {
      site_domains: 'example.com',
      site_root: '/var/www/example.com',
    }
  end

  it_behaves_like 'should try to detect bash pipe mode'

  it_behaves_like 'should print usage when invoked with', args: '-s -x'

  it_behaves_like 'should detect language'

  it_behaves_like 'should support russian prompts'

  it_behaves_like 'should not run under non-root'

  it_behaves_like 'should rotate log files', log_file_name: 'add-site.log'

  context 'without actual running commands' do
    include_context 'run in docker'
    let(:options) { '-p' }

    context 'nginx is installed, keitaro is installed, nginx is configured properly' do
      let(:command_stubs) { all_command_stubs }

      let(:commands) { make_proper_nginx_conf + make_keitaro_root_dir + make_site_root_dir }

      it_behaves_like 'should print to', :log, [
        "Try to found nginx\nFOUND",
        "Checking /etc/nginx/conf.d/vhosts.conf file existence\nYES",
        "Checking /var/www/keitaro directory existence\nYES",
        "Checking /var/www/example.com directory existence\nYES",
        "Checking keitaro params in /etc/nginx/conf.d/vhosts.conf\nOK"
      ]
    end

    context 'nginx is not installed' do
      it_behaves_like 'should print to', :log, "Try to found nginx\nNOT FOUND"

      it_behaves_like 'should exit with error', 'Your Keitaro installation does not properly configured'
    end

    context 'keitaro is not installed' do
      let(:command_stubs) { all_command_stubs }

      let(:commands) { make_proper_nginx_conf + make_site_root_dir }

      it_behaves_like 'should print to', :log, "Checking /var/www/keitaro directory existence\nNO"

      it_behaves_like 'should exit with error', 'Your Keitaro installation does not properly configured'
    end

    context 'site is not installed' do
      let(:command_stubs) { all_command_stubs }

      let(:commands) { make_proper_nginx_conf + make_keitaro_root_dir }

      it_behaves_like 'should print to', :log, "Checking /var/www/example.com directory existence\nNO"

      it_behaves_like 'should exit with error', '/var/www/example.com directory does not exist'
    end

    context 'programs are installed, nginx is not configured properly' do
      let(:command_stubs) { all_command_stubs }

      let(:nginx_conf) { "listen 80;" }

      let(:commands) { make_proper_nginx_conf + make_keitaro_root_dir + make_site_root_dir }

      it_behaves_like 'should print to', :log, "Checking keitaro params in /etc/nginx/conf.d/vhosts.conf\nERROR"

      it_behaves_like 'should exit with error', 'Your Keitaro installation does not properly configured'
    end

    context 'vhosts.conf is absent' do
      let(:command_stubs) { all_command_stubs }

      let(:commands) { make_keitaro_root_dir + make_site_root_dir }

      it_behaves_like 'should print to', :log, "Checking /etc/nginx/conf.d/vhosts.conf file existence\nNO"

      it_behaves_like 'should exit with error', 'Your Keitaro installation does not properly configured'
    end
  end

  describe 'creating vhost' do
    include_context 'run in docker'

    let(:command_stubs) { all_command_stubs }
    let(:commands) { make_proper_nginx_conf + make_keitaro_root_dir + make_site_root_dir }
    let(:save_files) { '/etc/nginx/conf.d/example.com.conf' }

    it 'should create example.com.conf' do
      run_script
      expect(File.exist?("#{@current_dir}/example.com.conf")).to be_truthy
    end

    it 'vhost file should be properly configured' do
      run_script
      content = File.read("#{@current_dir}/example.com.conf")
      expect(content).to match('server_name example.com;')
    end

    context '/etc/nginx/conf.d/example.com.conf already exists' do
      let(:make_example_com_vhost) { ['touch /etc/nginx/conf.d/example.com.conf'] }
      let(:commands) { make_proper_nginx_conf + make_keitaro_root_dir + make_site_root_dir + make_example_com_vhost }

      it_behaves_like 'should exit with error', 'Can not save site configuration - /etc/nginx/conf.d/example.com.conf already exists'
    end
  end

  describe 'add-site result' do
    include_context 'run in docker'

    let(:command_stubs) { all_command_stubs }
    let(:commands) { make_proper_nginx_conf + make_keitaro_root_dir + make_site_root_dir }

    it_behaves_like 'should print to', :stdout, /Everything is done!/
  end

  describe 'reloading nginx' do
    let(:options) { '-s -p' }

    it_behaves_like 'should print to', :log, /nginx -s reload/
  end
end
