require 'asciidoctor'
require 'asciidoctor/extensions'

Asciidoctor::Extensions.register do
  block_macro :example_block_macro do
    process do |parent, target, attributes|
      param = (attributes.has_key? 'param') ? attributes['param'] : 'no param'

      content = 'Example block macro. Passed param: ' + param
      content += ' target: ' + target
      create_paragraph parent, content, {}
    end
  end
end

Asciidoctor::Extensions.register do
  block :example_block do
    process do |parent, reader, attributes|
      param = (attributes.has_key? 'param') ? attributes['param'] : 'no param'

      content = 'Example block. Passed param: ' + param
      content += 'Block content: '
      for line in reader.lines
        content += line
      end
      create_paragraph parent, content, {}
    end
  end
end
