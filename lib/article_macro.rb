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
        text-indent:2em;
        line-height:1.5em;
   }
   table h2{
        text-indent:0.5em;
   }
   table h3{
        text-indent:1em;
   }
   .part{
      margin: 0 auto 0 auto;
   		font-size:2.2em;
   		font-weight:bold;
      line-height: 2em;
   		text-align:center;
   }
   .term_container{
      margin: 10px 0 10px 0;
   }
   .term_number{
      float:left;
      width: 4em;
      line-height:1.5em;
   }
   .term{
      float:left;
      width: 41em;
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

        part = args

        js = "var part = \"#{part}\";"
      	js = js + <<-eos
var numbers = [
  '一','二','三','四','五','六','七','八','九','十',
  '十一','十二','十三','十四','十五','十六','十七','十八','十九','二十',
  '二十一','二十二','二十三','二十四','二十五','二十六','二十七','二十八','二十九','三十',
  '三十一','三十二','三十三','三十四','三十五','三十六','三十七','三十八','三十九','四十',
  '四十一','四十二','四十三','四十四','四十五','四十六','四十七','四十八','四十九','五十'];

$('.part').each(function(index,element){
  element.innerText = '第' + numbers[index] + part + ' ' + element.innerText;
});


$('.term_number').each(function(index,element){
  element.innerText = '第' + numbers[index] + '条' + element.innerText;
});

$('#Container img').each(function(index,element){
  element.parentNode.setAttribute('style','text-align:center;width:100%;');
});

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
	    	content = "<div class=\"part\">#{args}</div>"
		    result = "#{ CGI::unescapeHTML(content) }".html_safe
	    	return result
		end
	end

  Redmine::WikiFormatting::Macros.register do
      desc "Article term"
      macro :term, :parse_args => false do |obj, args, text|
        content = "<div class=\"term_container\"><div class=\"term_number\"></div><div class=\"term\">#{args}</div><div style=\"clear:both;\"></div></div>"
        result = "#{ CGI::unescapeHTML(content) }".html_safe
        return result
    end
  end

end