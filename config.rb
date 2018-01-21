require './build-scripts/common'

# PROJECT SETTINGS
$project_name = 'Example Project'
$author = 'Maurice Müller'
$email = 'email@example.com'
$project_version = 'v1.0'
$theme = 'beige'

# VERSIONS
$revealjs_version = '3.6.0'
$decktape_version = '2.6.1'

# DIRECTORIES
$src_base = 'src'
$resources_base = $src_base + '/resources'
$doc_dir = $src_base + '/asciidoc'
$components_dir = $doc_dir + '/components'
$composites_dir = $doc_dir + '/composites'
$video_dir = $resources_base + '/videos'
$image_dir = $resources_base + '/images'
$generated_images_dir = $resources_base + '/generated'
$pdf_images_dir = $resources_base + '/pdf_images_dir'
$out_dir = 'out'
$revealjs_out_dir = '/revealjs'
$html_out_dir = '/html'
$asciidoc_pdf_out_dir = '/pdf'
$slides_pdf_out_dir =  '/slides-pdf'
$cordova_out_dir = '/cordova'
$custom_config_dir = $resources_base + '/custom_config'

$project_dir_escaped = escapeString("#{Dir.pwd}")

# SETTINGS
$custom_attributes = ''
$custom_attributes += " imagesoutdir=#{$project_dir_escaped}/#{$generated_images_dir}"
$custom_attributes += " author=#{escapeString($author)}"
$custom_attributes += " email=#{escapeString($email)}"
$custom_attributes += " project_name=#{escapeString($project_name)}"
$custom_attributes += " project_version=#{escapeString($project_version)}"
$custom_attributes += " comp=#{$project_dir_escaped}/#{escapeString($components_dir)}"

# CODE
# To add a custom language, use the following pattern:
# $custom_attributes += " java=#{Dir.pwd}/src/java"
# and access it like {java} in your .adoc files.

$custom_attributes += " java-src=#{$project_dir_escaped}/src/java/src"

# you can use highlight.js, coderay or pygments
$custom_attributes += ' source-highlighter=coderay'


# CORDOVA
# you only need those settings if you want to build an android or iOS app
$cordova_platforms = ['android']

# MISC
$project_name_escaped = escapeString($project_name)
