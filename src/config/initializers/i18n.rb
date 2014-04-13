require 'i18n'

I18n.enforce_available_locales = false

I18n.load_path = Dir[File.join(ROOT_PATH, 'src', 'config', 'locales', '**', '*.{rb,yml}')]
I18n.backend.load_translations

I18n.default_locale = :en
