RSpec::Matchers.define :have_attr_writer do |field|
  match do |object_instance|
    object_instance.respond_to?("#{field}=")
  end

  failure_message do |object_instance|
    "expected attr_writer for #{field} on #{object_instance}"
  end

  failure_message_when_negated do |object_instance|
    "expected attr_writer for #{field} not to be defined on #{object_instance}"
  end

  description do
    "checks to see if there is an attr writer on the supplied object"
  end
end