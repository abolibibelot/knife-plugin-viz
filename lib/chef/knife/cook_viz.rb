
module CookVizPlugins
  class CookbookViz < Chef::Knife
    banner "knife cookbook viz (options)"

    deps do
      require 'chef/cookbook_loader'
    end

    option :with_versions,
      :short => "-w",
      :long  => "--with-versions",
      :description => "Add version information in the graph",
      :boolean => true,
      :default => false

    def run
      config[:cookbook_path] ||= Chef::Config[:cookbook_path]
      ck_loader = Chef::CookbookLoader.new(config[:cookbook_path])
      cks = ck_loader.load_cookbooks
      puts 'digraph chef_cook {'
      if config[:with_versions]
        run_with_versions cks
      else
        cks.each do |name, ck|
          n = "#{name.gsub(/[:.-]/, '_')}"
          ck.metadata.dependencies.each do |dep_name, vc|
            dep_n = "#{dep_name.gsub(/[:.-]/, '_')}"
            puts "   #{n} -> #{dep_n};"
          end
        end
      end
      puts '}'
    end

    def run_with_versions(cks)
      cks.each do |name, ck|
        n = "#{name.gsub(/[:.-]/, '_')}"
        ck.metadata.dependencies.each do |dep_name, version_constraint|
          vc = Chef::VersionConstraint.new version_constraint
          dep_n = "#{dep_name.gsub(/[:.-]/, '_')}"
          if not cks.has_key? dep_name \
            or not vc.include?(cks[dep_name].metadata.version)
            style = 'dotted'
          end
          attrs = []
          attrs << "style=\"#{style}\"" unless style.nil?
          if vc.to_s != Chef::VersionConstraint::DEFAULT_CONSTRAINT
            attrs << "label=\"#{vc}\""
          end
          attrss = "[#{attrs.join ','}]"
          puts "   #{n} -> #{dep_n} #{attrss};"
        end
      end
    end
  end
end
