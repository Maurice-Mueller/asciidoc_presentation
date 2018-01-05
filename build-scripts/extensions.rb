require 'asciidoctor'
require 'asciidoctor/extensions'

# speaker-only::begin[] will be replaced with "[NOTE.speaker]\n--" for revealjs backend. speaker-only::end[] will
# be replaced with "--" for revealjs backend.
# For all other backends both tags will be replaced with "////" (i.e. starting/ending a multiline comment).
Asciidoctor::Extensions.register do
  preprocessor do
    process do |document, reader|
      returnLines = Array.new
      reader.readlines.each {|l|
        if !(l.start_with? 'speaker-only::begin[]') && !(l.start_with? 'speaker-only::end[]')
          returnLines.push(l)
          next
        elsif document.backend != 'revealjs'
          returnLines.push('////')
          next
        elsif l.start_with? 'speaker-only::begin[]'
          returnLines.push('[NOTE.speaker]')
          returnLines.push('--')
          next
        elsif l.start_with? 'speaker-only::end[]'
          returnLines.push('--')
          next
        end
      }
      Asciidoctor::Reader.new returnLines
    end
  end
end

# slides-only::begin[] and slides-only::end[] will be skipped for revealjs backend.
# For all other backends both will be replaced with "////" (i.e. starting / ending a multiline comment).
Asciidoctor::Extensions.register do
  preprocessor do
    process do |document, reader|
      returnLines = Array.new
      reader.readlines.each {|l|
        if !(l.start_with? 'slides-only::begin[]') && !(l.start_with? 'slides-only::end[]')
          returnLines.push(l)
          next
        elsif document.backend != 'revealjs'
          returnLines.push('////')
          next
        elsif l.start_with? 'slides-only::begin[]'
          next
        elsif l.start_with? 'slides-only::end[]'
          next
        end
      }
      Asciidoctor::Reader.new returnLines
    end
  end
end

# fragment::begin[] and fragment::end[] will be replaced with 'pass:[<p class="fragment">]' resp. 'pass:[</p>]'
# for revealjs backend. For all other backends both will be skipped.
Asciidoctor::Extensions.register do
  preprocessor do
    process do |document, reader|
      returnLines = Array.new
      reader.readlines.each {|l|
        if !(l.start_with? 'fragment::begin[]') && !(l.start_with? 'fragment::end[]')
          returnLines.push(l)
          next
        elsif document.backend != 'revealjs'
          next
        elsif l.start_with? 'fragment::begin[]'
          # returnLines.push('pass:[<p class="fragment">]')
          returnLines.push('[.fragment]')
          returnLines.push('--')
          next
        elsif l.start_with? 'fragment::end[]'
          returnLines.push('--')
          # returnLines.push('pass:[</p>]')
          next
        end
      }
      Asciidoctor::Reader.new returnLines
    end
  end
end

# slidebreak::[] will be replaced with "=== !" for revealjs backend and for all other backend it will be dropped.
Asciidoctor::Extensions.register do
  preprocessor do
    process do |document, reader|
      returnLines = Array.new
      reader.readlines.each {|l|
        if !(l.start_with? 'slidebreak::[]')
          returnLines.push(l)
          next
        elsif document.backend != 'revealjs'
          next
        elsif l.start_with? 'slidebreak::[]'
          returnLines.push('=== !')
          next
        end
      }
      Asciidoctor::Reader.new returnLines
    end
  end
end

############
# EXAMPLES
############

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
# WARNING: a custom include processor will replace current ones (e.g. the tag processor)
Asciidoctor::Extensions.register do
  include_processor do
    process do |doc, reader, target, attributes|
      source = File.read File.join(target)
      reader.push_include source.gsub("//include-processing::[]", "//INCLUDE PROCESSING"), target, target, 1, attributes
      reader
    end

    def handles? target
      # target.end_with? '.java'
    end
  end
end
