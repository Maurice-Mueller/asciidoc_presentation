# PROJECT SETTINGS
$project_name='project_name'
$theme='beige'

# VERSIONS
$revealjs_version = '3.6.0'
$decktape_version = '2.6.1'

# DIRECTORIES
$src_base = 'src'
$doc_dir = $src_base + '/asciidoc'
$index_file = $doc_dir + '/index.adoc'
$video_dir = $src_base + '/resources/videos'
$image_dir = $src_base + '/resources/images'
$generated_images_dir = $src_base + '/resources/generated'
$pdf_images_dir = $src_base + '/resources/pdf_images_dir'
$out_dir = 'out'
$revealjs_out_dir = $out_dir + '/revealjs'
$revealjs_out_file = $revealjs_out_dir + '/' + $project_name + '.html'
$html_out_dir = $out_dir + '/html'
$html_out_file = $html_out_dir + '/' + $project_name + '.html'
$asciidoc_pdf_out_dir = $out_dir + '/pdf'
$asciidoc_pdf_out_file = $asciidoc_pdf_out_dir + '/' + $project_name + '.pdf'
$slides_pdf_out_dir = $out_dir + '/slides-pdf'
$slides_pdf_file = $slides_pdf_out_dir + '/' + $project_name + '.pdf'
$custom_config_dir = $src_base + '/resources/custom_config'

$custom_attributes = ''
$custom_attributes += " imagesoutdir=#{Dir.pwd}/#{$generated_images_dir}"

# CODE
# To add a custom language, use the following pattern:
# $custom_attributes += " java=#{Dir.pwd}/src/java"
# and access it like {java} in your .adoc files.

$custom_attributes += " java-src=#{Dir.pwd}/src/java/src"

# you can use highlight.js, coderay or pygments
$custom_attributes += ' source-highlighter=coderay'
