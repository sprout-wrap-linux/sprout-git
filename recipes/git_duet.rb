#include_recipe 'homebrew'
include_recipe 'sprout-git::git_duet_global'
include_recipe 'sprout-git::git_duet_rotate_authors'
include_recipe 'sprout-git::authors'

working_file = '/tmp/linux_amd64.tar.gz'
working_dir = '/tmp/git-duet'

remote_file working_file do
  source 'https://github.com/git-duet/git-duet/releases/download/0.5.1/linux_amd64.tar.gz'
  mode '0755'
end

bash 'extract_module' do
  cwd ::File.dirname(working_file)
  code <<-EOH
    mkdir -p #{working_dir}
    tar xzf #{working_file} -C #{working_dir}
    mv #{working_dir}/* /usr/local/bin
    EOH
end

node['sprout']['git']['git_duet']['config'].each_pair do |setting, value|
  sprout_git_config setting do
    setting_value value
  end
end
