require 'fileutils'

desc "Install everything into the system"
task :default => [:symlinks, :os_dependent]

desc "Only symlink files"
task :symlinks do
  linkables = Dir.glob('*/**{.symlink}')

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|
    overwrite = false
    backup = false

    file = linkable.split('/').last.gsub(/\.symlink$/, "")
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)
      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite     = true
        when 'b' then backup        = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all    = true
        when 'S' then skip_all      = true
        end
      end

      if overwrite || overwrite_all
        FileUtils.rm_rf(target)
        `ln -s "$PWD/#{linkable}" "#{target}"`
      elsif backup || backup_all
        `mv "$HOME/.#{file}" "$HOME/.#{file}.backup"` if
        `ln -s "$PWD/#{linkable}" "#{target}"`
      elsif skip_all
        # do nothing
      end
    else
      `ln -s "$PWD/#{linkable}" "#{target}"`
    end
  end
end

OS_DEPENDENT_FILES = {
  "vscode/settings.json" => {
    "Darwin" => "~/Library/Application Support/Code/User/settings.json",
    "Linux"  => "~/.config/Code/User/settings.json"
  },
  "linux/terimnator-config" => {
    "Linux"  => "~/.config/terminator/config"
  }
}

desc "Symlink some files to specific places depending on the OS"
task :os_dependent do
  os = `uname`.chomp

  OS_DEPENDENT_FILES.each do |linkable, targets|
    if targets[os] && target = File.expand_path(targets[os])
      `mkdir -p #{File.dirname(target)}`
      `ln -s "#{File.expand_path(linkable)}" "#{target}"`
    end
  end
end
