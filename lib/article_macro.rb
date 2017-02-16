# coding: utf-8

module WikiMacro
	
	Redmine::WikiFormatting::Macros.register do
	    desc "Mark article for print begin"
	    macro :article_begin, :parse_args => false do |obj, args, text|

			header = args.split('|')[0]
			footer = args.split('|')[1]

		    style = <<-eos
@media all{
   #Container,#Container th,#Container td{
        border:none!important;
   }
   table p{
        margin: 12px 0!important;
        text-indent:2em;
   }
   table h2{
        text-indent:0.5em;
   }
   table h3{
        text-indent:1em;
   }

   .part{
   		text-indent:0!important;
   		font-size:2.5em;
   		font-weight:bold;
   		text-align:center;
   }
}
@media screen {
  #Container thead, #Container tfoot {
    display: none;
  }
  #blank{
    display: none;
  }
}

@media print {
  .breadcrumb,.toc,.pages-hierarchy{
    display:none!important;
  }
  #Cover{
    width:100%;
  }
  #Container hr{
    border: 1px solid black;
  }
  #Container thead {
    text-align: center;
    display: table-header-group;
  }
  #Container tfoot {
    display: table-footer-group;
  }
  #Cover{
    counter-reset: page 0;
  }
  .PageNum:after{
    float:right;
    content: "第" counter(page) "页";
    counter-increment: page;
  }
  #blank{
    height:15cm;
  }
}
eos

			headerHtml = "<thead class=\"Header\"><tr><td>#{header}<hr /></td></tr></thead>"
			footerHtml = "<tfoot><tr><td><hr /><span>#{footer}</span><span class=\"PageNum\"></span></td></tr></tfoot>"
			body = "<table id=\"Container\"> #{headerHtml} #{footerHtml} <tbody><tr><td>"

		    content = "<style type=\"text/css\">#{style}</style>" + body;

		    result = "#{ CGI::unescapeHTML(content) }".html_safe
	    	return result
	    end
	end

	Redmine::WikiFormatting::Macros.register do
	    desc "Mark article for print end"
	    macro :article_end, :parse_args => false do |obj, args, text|
	      	js = <<-eos
var node = $('#Container h1:first').get(0);
var h1=0;
var h2=0;
var h3=0;
while(node){
    if(node.tagName == 'H1'){
        h1++;h2=0;h3=0;
        node.innerText = h1+'. '+node.innerText;
    }
    if(node.tagName == 'H2'){
        h2++;h3=0;
        node.innerText = h1+'.'+h2+'. '+node.innerText;
    }
    if(node.tagName == 'H3'){
        h3++;
        node.innerText = h1+'.'+h2+'.'+h3+'. '+node.innerText;
    }
    node = node.nextSibling;
}
eos

			html = "</td></tr></tbody></table>"

			content = html + "<script>#{js}</script>"
		    result = "#{ CGI::unescapeHTML(content) }".html_safe
	    	return result

	    end
	end

	Redmine::WikiFormatting::Macros.register do
	    desc "Article part"
	    macro :part, :parse_args => false do |obj, args, text|
	    	content = "<p class=\"part\">#{args}</p>"
		    result = "#{ CGI::unescapeHTML(content) }".html_safe
	    	return result
		end
	end

end