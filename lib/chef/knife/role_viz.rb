
module RoleVizPlugins
  class RoleViz < Chef::Knife
    banner "knife role viz (options)"

    deps do
      require 'chef/role'
    end

    def run
      roles = Chef::Role.list(true)
      puts 'digraph chef_roles {'
      roles.each_value do |r|
        filtered_r = "#{r.name.gsub(':', '_').gsub('-', '_').gsub('.', '_')}"
        r.run_list.role_names.each do |i|
          filtered_i = "#{i.gsub(':', '_').gsub('-', '_').gsub('.', '_')}"
          puts "  role_#{filtered_r} -> role_#{filtered_i};"
        end
        deps = Array.new
        r.run_list.recipes.each do |i|
          recipe = i.gsub('-', '_').gsub('.', '_').split(':')[0]
          deps << recipe
        end
        deps.uniq.each do |d|
          puts "  role_#{filtered_r} -> #{d};"
        end
        puts "  #{filtered_r};" if r.run_list.role_names.empty? and r.run_list.recipes.empty?
      end
      puts '}'
    end

  end
end
