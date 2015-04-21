VCR.configure do |c|
  # Tell VCR where to save the cassettes (YAML files).
  c.cassette_library_dir = 'spec/support/fixtures'
  
  # Tell VCR which HTTP library to 'intercept.'
  c.hook_into :faraday
end