h1. What does it do?

This redmine plugin exposes extra macros in your redmine wikis. These macros are used to dynamically load css file, js file or inject raw HTML into your wiki page.

h2. Exposed Macros

* css_url()
* js_url()
* html()
* css()
* js()
* babel()
* import_react()
* import_antd()

h1. Examples

h2. Testing Plain HTML()

Below is a test for only the html(), js(), css(), css_url() and js_url() macros.

h2. HTML with line breaks

{{html
<ul>
   <li>option 1</li>
   <li>option 2</li>
   <li>option 3</li>
</ul>
}}

h2. HTML as oneliner

{{html(<ul><li>option 1</li><li>option 2</li><li>option 3</li></ul>)}}

h2. Raw js() macro

Inserting javascript to alert a message: <pre>alert('js() is working');</pre>

{{js
alert("js() is working");
}}

h2. Raw css() macro

Inserting RAW CSS to turn LI blue when in a UL of class rawcss
{{css
.rawcss li{ color:blue; }
}}
{{html(<ul class="rawcss"><li>option 1</li><li>option 2</li><li>option 3</li></ul>)}}

h2. Insert external JS and CSS files

Trying: 
- https://rawgithub.com/twbs/bootstrap/master/dist/css/bootstrap.min.css
- https://rawgithub.com/twbs/bootstrap/master/dist/js/bootstrap.min.js

Check the live DOM for these files at the bottom of the <code><head></code> section.

{{css_url('https://rawgithub.com/twbs/bootstrap/master/dist/css/bootstrap.min.css')}}
{{js_url('https://rawgithub.com/twbs/bootstrap/master/dist/js/bootstrap.min.js')}}


<pre><code>{{html
<ul>
   <li>option 1</li>
   <li>option 2</li>
   <li>option 3</li>
</ul>
}}</code></pre>

You can also use <code>css()</code> macro to embedd raw CSS into the middle of a wiki page.

<pre><code>{{css
.fooClass{
  color:red;
  padding:15px;
}
#barID{
  margin-left:15px;
}
}}</code></pre>

Include external static assets to your wiki page

<pre><code>{{css_url('https://rawgithub.com/twbs/bootstrap/master/dist/css/bootstrap.min.css')}}
{{js_url('https://rawgithub.com/twbs/bootstrap/master/dist/js/bootstrap.min.js')}}
</code></pre>




Useing React & Antd in wiki

<pre><code>
{{html
<div id="example"></div>
}}

{{import_react}}
{{import_antd}}

{{babel

const columns = [{
  title: 'Name',
  dataIndex: 'name',
  key: 'name',
  render: text => <a href="#">{text}</a>,
}, {
  title: 'Age',
  dataIndex: 'age',
  key: 'age',
}, {
  title: 'Address',
  dataIndex: 'address',
  key: 'address',
}, {
  title: 'Action',
  key: 'action',
  render: (text, record) => (
    <span>
      <a href="#">Action 一 {record.name}</a>
      <span className="ant-divider" />
      <a href="#">Delete</a>
      <span className="ant-divider" />
      <a href="#" className="ant-dropdown-link">
        More actions <antd.Icon type="down" />
      </a>
    </span>
  ),
}];

const data = [{
  key: '1',
  name: 'John Brown',
  age: 32,
  address: 'New York No. 1 Lake Park',
}, {
  key: '2',
  name: 'Jim Green',
  age: 42,
  address: 'London No. 1 Lake Park',
}, {
  key: '3',
  name: 'Joe Black',
  age: 32,
  address: 'Sidney No. 1 Lake Park',
}];

for(var i=4;i<100;i++){
  data.push({
  key: i,
  name: 'Joe Black',
  age: 32,
  address: 'Sidney No. 1 Lake Park',
  });
}


ReactDOM.render(
   <div>

   <div>
    <antd.Button type="primary" shape="circle" icon="search" />
    <antd.Button type="primary" icon="search">Search</antd.Button>
    <antd.Button shape="circle" icon="search" />
    <antd.Button icon="search">Search</antd.Button>
    <br />
    <antd.Button type="ghost" shape="circle" icon="search" />
    <antd.Button type="ghost" icon="search">Search</antd.Button>
    <antd.Button type="dashed" shape="circle" icon="search" />
    <antd.Button type="dashed" icon="search">Search</antd.Button>
   </div>

   <br />
   <antd.DatePicker />
   
   <br />
   <antd.Table dataSource={data} columns={columns} />

   </div>,
   document.getElementById('example')
);
}}</code></pre>



h1. See it in action

Visit the original blog post for a video of the plugin in action.
"arlocarreon.com/blog/redmine/redmine-wiki-html-utility/":http://www.arlocarreon.com/blog/redmine/redmine-wiki-html-utility/

h1. Installation

Navigate to:
@[redmine_install_path]/plugins@

Clone this repo:
@git clone git://github.com/mexitek/redmine_wiki_html_util.git@

Restart Redmine (example below is using bitnami stack): 
@sudo /etc/init.d/bitnami restart@

h1. License: "arlo.mit-license.org":http://arlo.mit-license.org
 
