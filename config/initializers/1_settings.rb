Lms::Settings = HashWithIndifferentAccess.new(Rails.application.config_for(:'lms'))

Lms::Settings[:url] = 'http://localhost:3000'