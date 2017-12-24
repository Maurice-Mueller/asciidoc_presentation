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

Asciidoctor::Extensions.register do
  preprocessor do
    process do |document, reader|
      Asciidoctor::Reader.new reader.readlines.map {|l|
        if l.start_with? 'replace-during-preprocessing::[]'
          next "this text was added during preprocessing"
        end
        next %(#{l})
      }
    end
  end
end

# A processor, that will be called if any external resources are included (e.g. source code, URIs, other adoc files, ...)
Asciidoctor::Extensions.register do
  include_processor do
    process do |doc, reader, target, attributes|
      source = File.read File.join(target)
      reader.push_include source.gsub("//include-processing::[]", "//INCLUDE PROCESSING"), target, target, 1, attributes
      reader
    end

    def handles? target
      target.end_with? '.java'
    end
  end
end