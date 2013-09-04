configuration do |c|
  # The name for your resulting application file (e.g., if the project_name is 'foo' then you'll get foo.jar, foo.exe, etc.)
  # default value: "jruby-libgdx-test"
  #
  # c.project_name = "jruby-libgdx-test"

  # Undocumented option 'output_dir'
  # default value: "package"
  #
  c.output_dir = "build"

  # The type of executable to create (console or gui)
  # default value: "gui"
  #
  #c.executable_type = "gui"

  # The main ruby file to invoke, minus the .rb extension
  # default value: "main"
  #
  c.main_ruby_file = "main"

  # The fully-qualified name of the main Java file used to initiate the application.
  # default value: "org.monkeybars.rawr.Main"
  #
  #c.main_java_file = "org.monkeybars.rawr.Main"

  # A list of directories where source files reside
  # default value: ["src"]
  #
  c.source_dirs = [
    "app",
    "app/extensions",
    "app/renderers",
    "lib/ruby"
  ]
  

  # A list of regexps of files to exclude
  # default value: []
  #
  #c.source_exclude_filter = []

  # The base directory that holds Mirah files, or subdirectories with Mirah files.
  # default value: "src"
  #
  #c.mirah_source_root = "src"

  # Whether Ruby source files should be compiled into .class files. Setting this to true currently breaks packaging
  # default value: false
  #
  #c.compile_ruby_files = false

  # A list of individual Java library files to include.
  # default value: []
  #
  #c.java_lib_files = []

  # A list of directories for rawr to include . All files in the given directories get bundled up.
  # default value: ["lib/java"]
  #
  #c.java_lib_dirs = ["lib/java"]

  # A list of files that will be copied into the `<output_dir>/jar` folder.  Note that the files maintain their directory path when copied. 
  # default value: []
  #
  c.files_to_copy = ['main.rb']

  # Undocumented option 'source_jvm_version'
  # default value: 1.7
  #
  c.source_jvm_version = 1.6

  # Undocumented option 'target_jvm_version'
  # default value: 1.7
  #
  c.target_jvm_version = 1.6

  # Undocumented option 'jvm_arguments'
  # default value: ""
  #
  #c.jvm_arguments = ""

  # Undocumented option 'java_library_path'
  # default value: ""
  #
  #c.java_library_path = ""

  # Undocumented option 'extra_user_jars'
  # default value: {}
  #
  #c.extra_user_jars[:data] = { :directory => 'data/images/png',
  #                             :location_in_jar => 'images',
  #                             :exclude => /*.bak$/ }
  c.extra_user_jars[:assets] = {
    :directory => 'assets',
    :location_in_jar => 'assets'
  }

  # Undocumented option 'verbose'
  # default value: false
  #
  #c.verbose = false

  # Undocumented option 'mac_do_not_generate_plist'
  # default value: false
  #
  #c.mac_do_not_generate_plist = false

  # working directory specified in plist file
  # default value: "$APP_PACKAGE"
  #
  #c.mac_plist_working_directory = "$APP_PACKAGE"

  # Undocumented option 'mac_icon_path'
  # default value: nil
  #
  #c.mac_icon_path = nil

  # Undocumented option 'windows_icon_path'
  # default value: nil
  #
  #c.windows_icon_path = nil

end
