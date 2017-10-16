class Rails::WebpackerAssetsGenerator < Rails::Generators::NamedBase
  def create_assets_file
    create_file "app/javascript/packs/#{file_name}.js", <<-FILE
  /* eslint no-console:0 */
  // This file is automatically compiled by Webpack, along with any other files
  // present in this directory. You're encouraged to place your actual application logic in
  // a relevant structure within app/javascript and only use these pack files to reference
  // that code so it'll be compiled.
  //
  // To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
  // layout file, like app/views/layouts/application.html.erb
    FILE
    create_file "app/assets/stylesheets/#{file_name}.scss", <<-FILE
  // Place all the styles related to the Projects controller here.
  // They will automatically be included in application.css.
  // You can use Sass (SCSS) here: http://sass-lang.com/
    FILE
  end
end
