FactoryBot.define do
  factory :config_desc, class: Dryad::Core::ConfigDesc do
    path { 'rails/config/database.yml' }
    payload { "default:&default\n  url: <%= DATABASE_URL %>\n" }
    version { 1 }

    initialize_with { new(path, payload, version) }
  end

  factory :portal, class: Dryad::Core::Portal do
    schema { Dryad::Core::Schema::HTTP }
    port { 80 }
    pattern { '*' }
  end

  factory :service, class: Dryad::Core::Service do
    name { 'rails' }
    address { 'localhost' }
    group { 'development' }
    portals { [build(:portal)] }
    priority { 10 }
  end

  factory :service_instance, class: Dryad::Core::ServiceInstance do
    name { 'rails' }
    schema { Dryad::Core::Schema::HTTP }
    address { 'localhost' }
    port { 3000 }
  end
end
