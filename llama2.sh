html_content=$(cat <<EOF
<!doctype html>
<html lang="en" lang="en-US" prefix="og: http://ogp.me/ns#" itemscope="" itemtype="http://schema.org/WebPage">
<head>
    <meta charset="utf-8">
  <link rel="profile" href="https://gmpg.org/xfn/11"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
  <title>
    
      PostgreSQL data types: what are they, and when to use each
  
  </title>
  <meta name="description" content="Let&#39;s take a look at the most commonly-used data types in Postgres and how they&#39;re used in practice, including examples.">

  <meta name="google-site-verification" content="F4slKAamcsa0oWVkUyz5Pkrv11HcukhMmME6hOz5u_w">
  <meta name="clarity-site-verification" content="ee042818-a2f7-4447-863a-5d843c0e99bf">


    
    

      
      <script>
        (function(h,o,u,n,d) {
          h=h[d]=h[d]||{q:[],onReady:function(c){h.q.push(c)}}
          d=o.createElement(u);d.async=1;d.src=n
          n=o.getElementsByTagName(u)[0];n.parentNode.insertBefore(d,n)
        })(window,document,'script','https://www.datadoghq-browser-agent.com/datadog-rum-v3.js','DD_RUM')
        DD_RUM.onReady(function() {
          DD_RUM.init({
            clientToken: 'pub4ca4d65c8d073132f3233fe9189a0fd3',
            applicationId: 'bd392428-cb13-4b5f-91c4-adbebdc6bb59',
            site: 'datadoghq.com',
            service:'www-cockroachlabs',
            env:'prod',
            
            
            sampleRate: 100,
            trackInteractions: true,
          })
        })
      </script>
      

    
    <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
            j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
            'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-NR8LC4');</script>
    

    
    <noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-NR8LC4"
                      height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
    
    

  <script>
    !function(){var analytics=window.analytics=window.analytics||[];if(!analytics.initialize)if(analytics.invoked)window.console&&console.error&&console.error("Segment snippet included twice.");else{analytics.invoked=!0;analytics.methods=["trackSubmit","trackClick","trackLink","trackForm","pageview","identify","reset","group","track","ready","alias","debug","page","once","off","on","addSourceMiddleware","addIntegrationMiddleware","setAnonymousId","addDestinationMiddleware"];analytics.factory=function(e){return function(){var t=Array.prototype.slice.call(arguments);t.unshift(e);analytics.push(t);return analytics}};for(var e=0;e<analytics.methods.length;e++){var key=analytics.methods[e];analytics[key]=analytics.factory(key)}analytics.load=function(key,e){var t=document.createElement("script");t.type="text/javascript";t.async=!0;t.src="https://cdn.segment.com/analytics.js/v1/" + key + "/analytics.min.js";var n=document.getElementsByTagName("script")[0];n.parentNode.insertBefore(t,n);analytics._loadOptions=e};analytics._writeKey="Mz68FzJ2r4poMQ4bQTniyvZF9yF0ycET";;analytics.SNIPPET_VERSION="4.15.3";
      analytics.load("Mz68FzJ2r4poMQ4bQTniyvZF9yF0ycET", {
        user: {
          cookie: {
            key: "crl_brand_ajs_user_id",
            oldKey: "crl_brand_ajs_user",
          },
          localStorage: {
            key: "crl_brand_ajs_user_traits",
          },
        },
        group: {
          cookie: {
            key: "crl_brand_ajs_group_id",
          },
          localStorage: {
            key: "crl_brand_ajs_group_properties",
          }
        }
      });
      analytics.page();
    }}();
  </script>

  <link rel="preconnect" href="https://d33wubrfki0l68.cloudfront.net">
  <link rel="preconnect" href="https://crl2020.imgix.net">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&family=Roboto+Mono:wght@500&family=Poppins:wght@200;300;400;500;600;700&family=Roboto+Mono:wght@100;200;400;500&family=Source+Sans+Pro:ital,wght@0,400;0,600;0,700;1,400;1,600&display=swap" rel="stylesheet">



  
  
    <link rel="preload" href="/main.css" as="style">
  

  
  
  <link rel="stylesheet" href="/main.css" />
  



  <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
  <script src="/js/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" defer></script>
  <script src="/js/bootstrap.min.js" defer></script>
    <link rel="icon" type="image/png" href="https://crl2020.imgix.net/img/crl-32x32.png" sizes="32x32">
    <link rel="icon" type="image/png" href="https://crl2020.imgix.net/img/crl-32x32.png?w=16h=16" sizes="16x16">
    <link rel="manifest" href="/manifest.json">
    <meta name="theme-color" content="#6933FF">
  
  
  <link rel="dns-prefetch" href="//www.cockroachlabs.com"/>
  <link rel="shortlink" href="/"/>
  
    
  <link rel="canonical" href="https://www.cockroachlabs.com/blog/postgres-data-types/"/>
<meta property="og:locale" content="en_US"/>
<meta property="og:type" content="article"/>
<meta property="og:title" content="

  PostgreSQL data types: what are they, and when to use each

"/>
<meta property="og:description" content="Let&#39;s take a look at the most commonly-used data types in Postgres and how they&#39;re used in practice, including examples."/>
<meta property="og:url" content="https://www.cockroachlabs.com/blog/postgres-data-types/"/>
<meta property="og:site_name" content="Cockroach Labs"/>


<meta property="article:publisher" content="https://www.facebook.com/cockroachlabs/"/>
<meta property="article:section" content="

    
        product
    

"/>

<meta property="article:published_time" content="2024-01-12 16:50:02.566 &#43;0000 UTC"/>




    
<meta property="article:tag" content="postgres"/>
    
<meta property="article:tag" content="postgresql"/>
    



<meta property="og:updated_time" content="2020-10-20T04:45:16+00:00"/>

<meta property="og:image" content="https://www.cockroachlabs.com/img/ugly-sweater-blog.png?auto=format,compress"/>
<meta property="og:image:secure_url" content="https://www.cockroachlabs.com/img/ugly-sweater-blog.png?auto=format,compress"/>


<meta name="twitter:card" content="summary_large_image"/>
<meta name="twitter:description" content="Let&#39;s take a look at the most commonly-used data types in Postgres and how they&#39;re used in practice, including examples."/>
<meta name="twitter:title" content="

  PostgreSQL data types: what are they, and when to use each

"/>
<meta name="twitter:site" content="@CockroachDB"/>
<meta name="twitter:image" content="

    https://www.cockroachlabs.com/img/ugly-sweater-blog.png

"/>
<meta name="twitter:creator" content="@CockroachDB"/>

  <script type="application/ld+json">{
    "@context": "https://schema.org",
    "@graph": [
        {
            "@type": "Organization",
            "@id": "https://www.cockroachlabs.com#organization",
            "name": "Cockroach Labs",
            "url": "https://www.cockroachlabs.com/blog/postgres-data-types/",
            "sameAs": [
                "https://www.facebook.com/cockroachlabs/",
                "https://www.instagram.com/cockroachDB/",
                "https://www.linkedin.com/company/cockroach-labs",
                "https://www.youtube.com/cockroachdb",
                "https://en.wikipedia.org/wiki/Cockroach_Labs",
                "https://twitter.com/CockroachDB"
            ],
            "logo": {
                "@type": "ImageObject",
                "@id": "https://www.cockroachlabs.com#logo",
                "url": "https://www.cockroachlabs.com/img/cockroach-labs-logo-dark.png",
                "caption": "Cockroach Labs"
            },
            "image": {
                "@id": "https://www.cockroachlabs.com#logo"
            }
        },
        {
            "@type": "WebSite",
            "@id": "https://www.cockroachlabs.com#website",
            "url": "https://www.cockroachlabs.com",
            "name": "Cockroach Labs",
            "publisher": {
                "@id": "https://www.cockroachlabs.com#organization"
            },
            "potentialAction": {
                "@type": "SearchAction",
                "target": "https://www.cockroachlabs.com/search/?q={search_term_string}",
                "query-input": "required name=search_term_string"
            }
        },
        {
            "@type": "WebPage",
            "@id": "https://www.cockroachlabs.com/blog/postgres-data-types/#webpage",
            "url": "https://www.cockroachlabs.com/blog/postgres-data-types/",
            "inLanguage": "en-US",
            "name": "PostgreSQL data types: what are they, and when to use each",
            "isPartOf": {
                "@id": "https://www.cockroachlabs.com#website"
            },

            "image": {
                "@type": "ImageObject",
                "@id": "https://www.cockroachlabs.com/blog/postgres-data-types/#primaryimage",
                "url": "/img/ugly-sweater-blog.png",
                "caption": ""
            },
            "primaryImageOfPage": {
                "@id": "https://www.cockroachlabs.com/blog/postgres-data-types/#primaryimage"
            },

            "datePublished": "2024-01-12 16:50:02.566 &#43;0000 UTC",
            "dateModified": "2024-01-12 16:50:02.566 &#43;0000 UTC",
            "description": "Let&#39;s take a look at the most commonly-used data types in Postgres and how they&#39;re used in practice, including examples.",
            "breadcrumb": {
                "@id": "https://www.cockroachlabs.com/blog/postgres-data-types/#breadcrumb"
            }
        },
        {
            "@type": "BreadcrumbList",
            "@id": "https://www.cockroachlabs.com/blog/postgres-data-types/#breadcrumb",
            "itemListElement": [
                {
                    "@type": "ListItem",
                    "position": 1,
                    "item": {
                        "@type": "WebPage",
                        "@id": "https://www.cockroachlabs.com",
                        "url": "https://www.cockroachlabs.com",
                        "name": "Home"
                    }
                }
                
                    ,
                    
                    {
                        "@type": "ListItem",
                        "position": 2,
                        "item": {
                            "@type": "WebPage",
                            "@id": "https://www.cockroachlabs.com/blog/",
                            "url": "https://www.cockroachlabs.com/blog/",
                            "name": "Blog"
                        }
                    },
                    {
                        "@type": "ListItem",
                        "position": 3,
                        "item": {
                            "@type": "WebPage",
                            "@id": "https://www.cockroachlabs.com/blog/postgres-data-types/",
                            "url": "https://www.cockroachlabs.com/blog/postgres-data-types/",
                            "name": "PostgreSQL data types: what are they, and when to use each"
                        }
                    }
                    
                
            ]
        }
        
         ,
         {
            "@context": "https://schema.org",
            "@type": "NewsArticle",
            "mainEntityOfPage": {
              "@type": "WebPage",
              "@id": "https://google.com/article"
            },
            "headline": "PostgreSQL data types: what are they, and when to use each",
            "image": [
              "https://crl2020.imgix.net//img/ugly-sweater-blog.png"
            ],
            "datePublished": "2024-01-12 16:50:02.566 &#43;0000 UTC",
            "dateModified": "2024-01-12 16:50:02.566 &#43;0000 UTC",
            "author": {
                "@type": "Person",
                "url": "https://www.cockroachlabs.com/blog/postgres-data-types/",
                "name": "
                    
                    Charlie Custer
                
                "
            }, 
            "publisher": {
              "@type": "Organization",
              "name": "Cockroach Labs",
              "logo": {
                "@type": "ImageObject",
                "url": "https://crl2020.imgix.net/img/cockroachlabs-logo-170.png?auto=format,compress"
              }
            }
          }
        
    ]
}</script>

  


  

  <link rel="alternate" type="application/rss+xml" title="Cockroach Labs » Feed" href="https://www.cockroachlabs.com/feed/"/>

  

  

  

  

  





<script src="https://cdn.c212.net/c.min.js"></script>
<script language="javascript">
cidconv.setClientId("WHLkqT71");
cidconv.addEvent("e9", "1");
cidconv.sendEvents();
</script>


   
</head>  

  
  

  <body class=" sans-serif  blog page "  data-spy="scroll" data-target="#jumpnav"  >

    <div class="nav-holder">

      




    
    
    
    


<div class="shadow-sm main-nav-wrapper position-relative

">

<div class="container-xl main-nav main-nav-contained-800 ">
  <nav class="navbar navbar-expand-lg navbar-light">
    <a class="navbar-brand mr-0 mr-md-2 d-xl-block mt-auto" href="/"><img width="170" height="24" alt="Cockroach Labs" class="br0 db mb0" src="https://crl2020.imgix.net/img/cockroachlabs-logo-170.png?auto=format,compress"></a>
    <button
      class="navbar-toggler"
      type="button"
      data-toggle="collapse"
      data-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">

      
      <div class="d-lg-none pt-2">
        <div class="accordion " id="accordionExample">

          
          <div class="card">
            <div class="card-header bg-white" id="mobileProduct">
                <h2 class="mb-0">
                    <button class="btn btn-link btn-block text-left d-flex justify-content-between align-items-center" type="button" data-toggle="collapse"
                        data-target="#collapseProduct" aria-expanded="false" aria-controls="mobileProduct">
                        Product
                    </button>
                </h2>
            </div>
            <div id="collapseProduct" class="collapse" aria-labelledby="mobileProduct" data-parent="#accordionExample">
              <div class="card-body bg-gray-f4">
                <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">
<div class="col-md-6">
    <p class="font-size-16 lh-n semibold my-3">Capabilities</p>
    <ul class="mb-0 mb-md-3 list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/scale/">Elastic Scale
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/kubernetes/">Cloud-Native &amp; Kubernetes
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/resilience/">Built-in Survivability
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>
<div class="col-md-6">
    <p class="d-none d-md-block font-size-16 lh-n semibold my-3">&nbsp;</p>
    <ul class="list-unstyled p-0">
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/sql/">Familiar, Consistent SQL
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/geo-partitioning/">Global Data
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
    </ul>
</div>
</div>
              </div>
            </div>
          </div>

          
          <div class="card">
            <div class="card-header bg-white" id="mobileSolutions">
                <h2 class="mb-0">
                    <button class="btn btn-link btn-block text-left d-flex justify-content-between align-items-center" type="button" data-toggle="collapse"
                        data-target="#collapseSolutions" aria-expanded="false" aria-controls="mobileSolutions">
                        Solutions
                    </button>
                </h2>
            </div>
            <div id="collapseSolutions" class="collapse" aria-labelledby="mobileSolutions" data-parent="#accordionExample">
              <div class="card-body bg-gray-f4">
                <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">
<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3 text-primary">By Industries</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/financialservices/">Finance
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/gaming/">Gaming
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/manufacturing-logistics/">Manufacturing &amp; Logistics
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/media/">Media and Streaming
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>
<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3 text-primary">&nbsp;</p>
    <ul class="list-unstyled p-0">
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/gambling/">Real-Money Gaming
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/retail-ecommerce/">Retail &amp; eCommerce
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/saas/">SaaS
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/startups/">Startups
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
        </ul>
</div>

<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3">Customer Stories</p>
    <div>
        <p class="mb-4 mt-0 font-size-16 lh-n">
            See how our customers use CockroachDB to handle their critical workloads.
        </p>
        <div class="pb-45">
            <a class="btn btn-black rounded-pill px-4 py-2" href="/customers/">Read case studies</a>
        </div>
    </div>
</div>

</div>

              </div>
            </div>
          </div>

          

          <div class="card">
            <div class="card-header bg-white" id="mobileResources">
                <h2 class="mb-0">
                    <button class="btn btn-link btn-block text-left d-flex justify-content-between align-items-center" type="button" data-toggle="collapse"
                        data-target="#collapseResources" aria-expanded="false" aria-controls="mobileResources">
                        Resources
                    </button>
                </h2>
            </div>
            <div id="collapseResources" class="collapse" aria-labelledby="mobileResources" data-parent="#accordionExample">
              <div class="card-body bg-gray-f4">
                <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">

<div class="col-md-4">
    <div>
        <div class="mb-4 mt-3 text-primary font-weight-medium font-size-16 lh-n">
            <h3 class='text-primary'>Cockroach <br>University</h3>World-class training and tutorials for beginners and advanced use cases.
        </div>
        <div class="pb-45">
            <a class="btn btn-primary rounded-pill px-4 py-2" href="/cockroach-university/">Sign up for free</a>
        </div>
    </div>
</div>

<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3">Learn</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/resources/">Resource center
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/blog/">Blog
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/developers/">Developers
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/community/webinars/">Webinars
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/big-ideas-podcast/">Podcast
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>
<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3">Support</p>
    <ul class="list-unstyled p-0">
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="https://forum.cockroachlabs.com/">Forum
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="https://github.com/cockroachdb/cockroach">GitHub
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/join-community/">Slack
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="https://support.cockroachlabs.com/hc/en-us">Support Portal
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
        </ul>
</div>
</div>
              </div>
            </div>
          </div>

          

          <div class="card">
            <div class="card-header bg-white" id="mobileDocs">
                <h2 class="mb-0">
                    <button class="btn btn-link btn-block text-left d-flex justify-content-between align-items-center" type="button" data-toggle="collapse"
                        data-target="#collapseDocs" aria-expanded="false" aria-controls="mobileDocs">
                        Docs
                    </button>
                </h2>
            </div>
            <div id="collapseDocs" class="collapse" aria-labelledby="mobileDocs" data-parent="#accordionExample">
              <div class="card-body bg-gray-f4">
                <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">

<div class="col-md-6">
    <div>
        <div class="mb-4 mt-3 text-primary font-weight-medium font-size-16 lh-n">
            <h3 class='text-primary'>Docs Hub<br></h3> Access tutorials, guides, example applications, and much more.
        </div>
        <div class="pb-md-45">
            <a class="btn btn-primary rounded-pill px-4 py-2" href="https://www.cockroachlabs.com/docs/">Explore</a>
        </div>
    </div>
</div>

<div class="col-md-6">
    <p class="font-size-16 lh-n semibold mb-1 mt-0">&nbsp;</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/cockroachcloud/quickstart">Quickstart
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/stable/frequently-asked-questions">FAQ
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/stable/example-apps">Example applications
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/stable/architecture/overview">Architecture Overview
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>

</div>
              </div>
            </div>
          </div>

          

          

          

          <div class="card">
            <div class="card-header bg-white" id="mobileCustomers">
                <h2 class="mb-0">
                    <button class="btn btn-link btn-block text-left d-flex justify-content-between align-items-center" type="button" data-toggle="collapse"
                        data-target="#collapseCompany" aria-expanded="false" aria-controls="mobileCustomers">
                        Customers
                    </button>
                </h2>
            </div>
            <div id="collapseCompany" class="collapse" aria-labelledby="mobileCustomers" data-parent="#accordionExample">
              <div class="card-body bg-gray-f4">
                <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">
<div class="col-md-5 px-45">
    <p class="font-size-16 lh-n semibold mt-4 mb-2 text-primary">Featured stories</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/about-allsaints/">AllSaints
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/hard-rock-digital/">Hard Rock Digital
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/blog/persistence-as-a-service-at-netflix/">Netflix
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/shipt/">Shipt
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/eliminating-data-silos-for-distributed-workloads/">Starburst
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
    <a href="/customers/" class="mt-3 all-customer-links d-block">All customer stories</a>
</div>

<div class="col-md-6 offset-md-1">
    <div>
        <a href="https://www.cockroachlabs.com/roachfest/2023/">
            <img src="https://crl2020.imgix.net/img/rf-2023-watch.png?auto=format,compress" alt="RoachFest 2023" style="width: 303px;" class="mt-4 mt-md-0">
        </a>
    </div>
</div>

</div>

              </div>
            </div>
          </div>

          
          <div class="card">
            <div class="card-header bg-white" id="mobileBlog">
                <h2 class="mb-0">
                    <a class="btn btn-link btn-block text-left btn-link-chevron-right d-flex justify-content-between align-items-center" href="/featured-blog/">Blog</a>
                </h2>
            </div>
          </div>
          <div class="card">
            <div class="card-header bg-white" id="">
                <h2 class="mb-0">
                    <a class="btn btn-link btn-block text-left d-flex justify-content-between align-items-center" href="/pricing/">Pricing</a>
                </h2>
            </div>
          </div>
          <div class="card">
            <div class="card-header bg-white" id="">
                <h2 class="mb-0">
                    <a class="btn btn-link btn-block text-left btn-link-chevron-right d-flex justify-content-between align-items-center" href="/contact/">Contact us</a>
                </h2>
            </div>
          </div>

          <div class="card">
            <div class="card-header bg-white" id="">
                <h2 class="mb-0">
                    <a class="btn btn-link btn-block text-left" href="https://cockroachlabs.cloud/">Sign In</a>
                </h2>
            </div>
          </div>


        </div>
      </div>
      
      
      <ul class="d-none d-lg-flex navbar-nav mr-auto mb-2 mb-lg-0 mt-auto">
        <li class="nav-item dropdown position-static">
          <a
          class="nav-link dropdown-toggle"
          href="#"
          id="navbarDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false">Product</a>
          <div class="dropdown-menu w-100 p-45" aria-labelledby="navbarDropdown">
            <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">
<div class="col-md-6">
    <p class="font-size-16 lh-n semibold my-3">Capabilities</p>
    <ul class="mb-0 mb-md-3 list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/scale/">Elastic Scale
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/kubernetes/">Cloud-Native &amp; Kubernetes
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/resilience/">Built-in Survivability
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>
<div class="col-md-6">
    <p class="d-none d-md-block font-size-16 lh-n semibold my-3">&nbsp;</p>
    <ul class="list-unstyled p-0">
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/sql/">Familiar, Consistent SQL
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/product/geo-partitioning/">Global Data
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
    </ul>
</div>
</div>
          </div>
        </li>

        <li class="nav-item dropdown position-static">
          <a
          class="nav-link dropdown-toggle"
          href="#"
          id="navbarDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false">Solutions</a>
          <div class="dropdown-menu w-100 p-45" aria-labelledby="navbarDropdown">
            <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">
<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3 text-primary">By Industries</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/financialservices/">Finance
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/gaming/">Gaming
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/manufacturing-logistics/">Manufacturing &amp; Logistics
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/media/">Media and Streaming
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>
<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3 text-primary">&nbsp;</p>
    <ul class="list-unstyled p-0">
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/gambling/">Real-Money Gaming
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/retail-ecommerce/">Retail &amp; eCommerce
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/saas/">SaaS
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/solutions/verticals/startups/">Startups
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
        </ul>
</div>

<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3">Customer Stories</p>
    <div>
        <p class="mb-4 mt-0 font-size-16 lh-n">
            See how our customers use CockroachDB to handle their critical workloads.
        </p>
        <div class="pb-45">
            <a class="btn btn-black rounded-pill px-4 py-2" href="/customers/">Read case studies</a>
        </div>
    </div>
</div>

</div>

          </div>
        </li>

        <li class="nav-item dropdown position-static">
          <a
          class="nav-link dropdown-toggle"
          href="#"
          id="navbarDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false">Resources</a>
          <div class="dropdown-menu w-100 p-45" aria-labelledby="navbarDropdown">
            <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">

<div class="col-md-4">
    <div>
        <div class="mb-4 mt-3 text-primary font-weight-medium font-size-16 lh-n">
            <h3 class='text-primary'>Cockroach <br>University</h3>World-class training and tutorials for beginners and advanced use cases.
        </div>
        <div class="pb-45">
            <a class="btn btn-primary rounded-pill px-4 py-2" href="/cockroach-university/">Sign up for free</a>
        </div>
    </div>
</div>

<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3">Learn</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/resources/">Resource center
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/blog/">Blog
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/developers/">Developers
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/community/webinars/">Webinars
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/big-ideas-podcast/">Podcast
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>
<div class="col-md-4">
    <p class="font-size-16 lh-n semibold my-3">Support</p>
    <ul class="list-unstyled p-0">
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="https://forum.cockroachlabs.com/">Forum
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="https://github.com/cockroachdb/cockroach">GitHub
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="/join-community/">Slack
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
            <li class="border-bottom">
                <a class="text-xs text-black d-flex pb-2 pt-3" href="https://support.cockroachlabs.com/hc/en-us">Support Portal
                    <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                        </svg>                    
                </a> 
            </li>
        
        </ul>
</div>
</div>
          </div>
        </li>


        <li class="nav-item dropdown position-static">
          <a
          class="nav-link dropdown-toggle"
          href="#"
          id="navbarDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false">Docs</a>
          <div class="dropdown-menu w-100 p-45 docs" aria-labelledby="navbarDropdown">
            <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">

<div class="col-md-6">
    <div>
        <div class="mb-4 mt-3 text-primary font-weight-medium font-size-16 lh-n">
            <h3 class='text-primary'>Docs Hub<br></h3> Access tutorials, guides, example applications, and much more.
        </div>
        <div class="pb-md-45">
            <a class="btn btn-primary rounded-pill px-4 py-2" href="https://www.cockroachlabs.com/docs/">Explore</a>
        </div>
    </div>
</div>

<div class="col-md-6">
    <p class="font-size-16 lh-n semibold mb-1 mt-0">&nbsp;</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/cockroachcloud/quickstart">Quickstart
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/stable/frequently-asked-questions">FAQ
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/stable/example-apps">Example applications
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="https://www.cockroachlabs.com/docs/stable/architecture/overview">Architecture Overview
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
</div>

</div>
          </div>
        </li>


        <li class="nav-item dropdown position-static">
          <a
          class="nav-link dropdown-toggle"
          href="#"
          id="navbarDropdown"
          role="button"
          data-toggle="dropdown"
          aria-haspopup="true"
          aria-expanded="false">Customers</a>
          <div class="dropdown-menu w-100 p-0 company" aria-labelledby="navbarDropdown">
            <button class="d-none d-md-block btn-close position-absolute"></button>
<div class="row">
<div class="col-md-5 px-45">
    <p class="font-size-16 lh-n semibold mt-4 mb-2 text-primary">Featured stories</p>
    <ul class="list-unstyled p-0">
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/about-allsaints/">AllSaints
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/hard-rock-digital/">Hard Rock Digital
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/blog/persistence-as-a-service-at-netflix/">Netflix
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/shipt/">Shipt
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
        <li class="border-bottom">
            <a class="text-xs text-black d-flex pb-2 pt-3" href="/customers/eliminating-data-silos-for-distributed-workloads/">Starburst
                <svg class="ml-auto" width="11" height="10" viewBox="0 0 11 10" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd" clip-rule="evenodd" d="M5.98691 0.624521L9.97887 4.61648C10.2238 4.86145 10.2238 5.25862 9.97887 5.50358L5.98691 9.49554C5.74195 9.74051 5.34478 9.74051 5.09981 9.49554C4.85485 9.25057 4.85485 8.85341 5.09981 8.60844L8.02094 5.68731H0.789873C0.443439 5.68731 0.162598 5.40647 0.162598 5.06003C0.162598 4.7136 0.443439 4.43276 0.789873 4.43276H8.02094L5.09981 1.51162C4.85485 1.26666 4.85485 0.869487 5.09981 0.624521C5.34478 0.379554 5.74195 0.379554 5.98691 0.624521Z" fill="black"/>
                    </svg>                    
            </a> 
        </li>
    
    </ul>
    <a href="/customers/" class="mt-3 all-customer-links d-block">All customer stories</a>
</div>

<div class="col-md-6 offset-md-1">
    <div>
        <a href="https://www.cockroachlabs.com/roachfest/2023/">
            <img src="https://crl2020.imgix.net/img/rf-2023-watch.png?auto=format,compress" alt="RoachFest 2023" style="width: 303px;" class="mt-4 mt-md-0">
        </a>
    </div>
</div>

</div>

          </div>
        </li>

        <li class="nav-item dropdown position-static">
          <a
          class="nav-link dropdown-toggle no-chevron"
          href="/pricing/"
          id="navbarDropdown"
          >Pricing</a>
        </li>
      </ul>
      

      
      <div class="ml-auto">
        <ul class="d-none d-lg-flex navbar-nav mr-auto mb-2 mb-lg-0 mt-auto">
          <li class="nav-item">
            <a class="nav-link nav-text-md" href="/contact/" role="button"> Contact us</a>
            <a class="nav-link nav-icon-md" href="/contact/" role="button"><img class="" width="32" src="https://d33wubrfki0l68.cloudfront.net/7ffb43afb5e068be42ae20c0e8b8672b0f4c18f4/dbc2d/img/icons/icon-envelope.png" alt="Sign in"></a>
          </li>
          <li class="nav-item">
            <a href="https://cockroachlabs.cloud/" class="nav-link nav-text-md">Sign In</a>
            <a href="https://cockroachlabs.cloud/" class="nav-link nav-icon-md">
              <svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg">
              <circle cx="11" cy="11" r="10.25" fill="white" stroke="black" stroke-width="1.5"/>
              <circle cx="11" cy="9" r="2.25" stroke="black" stroke-width="1.5"/>
              <path d="M6 16C6.47619 14.6667 8.14286 12 11 12C13.8571 12 15.5238 14.6667 16 16" stroke="black" stroke-width="1.5" stroke-linecap="round"/>
              </svg>
              </a>
          </li>
          <li class="nav-item d-flex justify-content-center flex-column">
            <a class="btn btn-primary rounded-pill px-3 font-family-poppins py-1 ml-2 start-instantly-nav-btn" href="https://cockroachlabs.cloud/signup">Start instantly</a>
          </li>
        </ul>
      </div>
      
    </div>
  </nav>
</div>
</div>

    
  

  </div>


    

<div class="blog-back-header py-3">
  <div class="container">
    <div class="row">
      <div class="col-md-3 pb-0"><a href="/blog/">← <strong>Back to Blog</strong></a></div>
    </div>
  </div>
</div>


<script>
 $(document).ready(function() {
 	$('.blog-post h2').each(function(i) {
  $('[data-toggle="tooltip"]').tooltip()
    value = $(this).html();
    url = window.location.pathname;
    linkanchor = $(this).attr('id');
    fulllink = "https://cockroachlabs.com" + url + "#" + linkanchor;
    $(this).append('<span class="copy-btn copy_link" data-toggle="tooltip" data-placement="bottom" title="Copy link to section." data-type="attribute" data-attr-name="data-clipboard-text" data-clipboard-text="'+fulllink+'"><img src="/img/cockroach-section-link.svg" width="20" height="20" class="ml-2"/></span>');
 	});
   $('.copy-btn').on("click", function(){
        value = $(this).data('clipboard-text');
        var $temp = $("<input>");
          $("body").append($temp);
          $temp.val(value).select();
          document.execCommand("copy");
          alert('Link copied.')
          $temp.remove();
    })
 });
</script>

  

<div class="container">
  <div class="row pt-7 pb-45">
    <div class="col-md-10 m-auto text-center">
      <h1 class="h2 mb-3" itemprop="headline">PostgreSQL data types: what are they, and when to use each</h1>
  </div>

  <div class="row mb-3 text-center authors">
    <div class="col-md-12">
      <div class="">
        
        <ul class="list-inline authors-list">
          <li class="d-inline-block"><p class="m-0">Written by </p></li>
        

              
                  
                  
                  
                  
                  <li class="d-inline-block"><a href="https://www.cockroachlabs.com/blog/author/charlie-custer/">Charlie Custer</a></li>
             


        
          <li class="d-inline-block"><p class="m-0" itemprop="datePublished" pubdate="">on January 12, 2024</p></li>
        </ul>
      </div>
    </div>
  </div>
</div>
</div>


  <div class="container" style="position: relative;">
    <div class="row mb-6 text-center">
      <div class="col-md-11 m-auto">
        <img class="featured-image" src="https://crl2020.imgix.net/img/ugly-sweater-blog.png?auto=format,compress&q=60&w=1185" width="1185" height="395" loading="lazy?auto=format,compress&max-w=700" alt="PostgreSQL data types: what are they, and when to use each" itemprop="image" fetchpriority="high"/>
      </div>
    </div>
    
    <div class="row mb-4">
      
      <div class="col-md-4 col-lg-3 h-100 sticky-100">
        <div class="sidebar-section">
          <div class="sidebar-item sticky-top">
            <div class="sidebar-content">
              <div class="jumpnav list-group navbar-jumpnav pb-3 sticky-0" id="jumpnav">  
                <p class="title">Content</p>
                  
                  <a class="list-group-item" href="#boolean-data-types" title="Boolean data types">Boolean data types</a>
                  
                  <a class="list-group-item" href="#character-data-types-in-postgres" title="Character data types in Postgres">Character data types in Postgres</a>
                  
                  <a class="list-group-item" href="#numeric-data-types" title="Numeric data types">Numeric data types</a>
                  
                  <a class="list-group-item" href="#time-and-date-data" title="Time and date data">Time and date data</a>
                  
                  <a class="list-group-item" href="#uuids" title="UUIDs">UUIDs</a>
                  
                  <a class="list-group-item" href="#json-data-types" title="JSON data types">JSON data types</a>
                  
                  <a class="list-group-item" href="#arrays" title="Arrays">Arrays</a>
                  
                  <a class="list-group-item" href="#special-data-types-in-postgres" title="Special data types in Postgres">Special data types in Postgres</a>
                  
                  <a class="list-group-item" href="#data-types-in-postgres-vs-cockroachdb" title="Data types in Postgres vs. CockroachDB">Data types in Postgres vs. CockroachDB</a>
                  
                  <div class="newsletter-signup">
                    
                    <style>.mktoButtonRow {position: absolute; top: 0; right: 0; margin-left: auto; width: 68px !important;}.form-control {border-radius: 25px;font-size: 15px !important;}.blog-subscribe-btn {height: 44px}</style>

                    <p><strong>Subscribe to our newsletter</strong></p>
                    <script src="//go.cockroachlabs.com/js/forms2/js/forms2.js"></script>
                    <div class="mkto-fluid"><form id="mktoForm_1084"></form></div>
                    <p class="js-ty" style="display: none;">Thank you!</p>
            
                    
                    <script>MktoForms2.loadForm("//go.cockroachlabs.com", "350-QIN-827", 1084,
                    function (form) {
                        
                        $(".mktoClear").remove();
                        $(".mktoHtmlText").css("color", "#7a7a7a");
                        $(".mktoButtonWrap").css("text-align", "center");
                        $("#mktoForm_1084")
                        .addClass("position-relative");
                        $("button.mktoButton")
                        .removeClass("mktoButton")
                        .addClass("btn btn-sm btn-primary blog-subscribe-btn");
                        $("input.mktoEmailField")
                        .addClass("form-control input-no-focus border-0 js-signup-email mb-0");
                         $(".blog-subscribe-btn").html('<img src="/img/mail-icon-newsletter.png" width="18" height="11">');

                        form.onSuccess(function(values, followUpUrl) {
                        
                                                       
                        
                        document.querySelector('.js-ty').style.display = 'block';
                        
                        document.querySelector('.mktoButtonWrap').style.display = 'none';
            
                        window.dataLayer.push({
                        "event": "mkto.form.success",
                        "mkto.form.id": form.getId()
                        });
                        return false;
                        });     
                    });
              </script>
                  <script>
                  const signUpForm = document.querySelector('.js-signup-cloud-submit');
                  
                  signUpForm.addEventListener("submit", function(e){
                  
                    e.preventDefault();
                    let emailInput = document.querySelector('.js-signup-email');
                  
                    const form = document.querySelector('#mktoForm_1084');
                      if(emailInput.value){
                        const marketoEmailInput = document.getElementById('Email');
                        marketoEmailInput.value = emailInput.value;
                  
                        MktoForms2.whenReady(function (form) {
                          form.submit();
                        });
                  
                      }
                  
                  });
                  </script> 
                  <script>
                    MktoForms2.whenReady(function handleReady (form) {
                              window.dataLayer.push({
                                  "event": "mkto.form.ready",
                                  "mkto.form.id": form.getId()
                        });
                      });
                  </script> 
                  <script>
                    MktoForms2.whenReady(function handleReady(form) {
                      form.onSuccess(function handleSuccess(values, followUpUrl) {
                        window.dataLayer.push({
                          "event": "mkto.form.success",
                            "mkto.form.id": form.getId()
                        });
                      });
                    });
                  </script> 
                  </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      

        <div class="  col-md-8 scrollspy  imgs-fluid blog-post">
          
          <div class="post-callout py-45 px-45 mb-4">

            

            
            <h3 class="my-2">
              Cloud-native Postgres?
            </h3>
            
            <p>What if you could get all the advantages of Postgres, PLUS automated sharding, elastic scaling, and a multi-active setup that allows every node to accept reads AND writes for extreme resilience? </p>
  
             
              <a href="https://cockroachlabs.com" class="btn blog-custom-cta read-more-btn  cta-cloud-native-postgres">You can.</a> 
            
          </div>
            

        <h1 id="postgresql-data-types-what-are-they-and-when-to-use-each">PostgreSQL data types: what are they, and when to use each</h1>
<p>Enforcing strict data types is one of the major advantages of relational databases, and PostgreSQL is one of the most popular open-source relational database options. In this article, we’ll look at many of the most commonly used data types in Postgres, how they’re used, and even how they map to more advanced distributed SQL databases.</p>
<p>(Note that when in doubt, you should always refer to <a href="https://www.postgresql.org/docs/current/datatype.html" target="_blank" rel="noopener">Postgres’s official documentation</a> for the latest information).</p>
<h2 id="boolean-data-types">Boolean data types</h2>
<table>
<thead>
<tr>
<th>Data type</th>
<th>Size</th>
<th>Values allowed</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>boolean</code></td>
<td>1 byte</td>
<td><code>true</code> and <code>false</code> (plus aliases, see below)</td>
</tr>
</tbody>
</table>
<p>The <code>boolean</code> data type stores true/false values. Note that this datatype also allows inputs of <code>yes</code>, <code>on</code>, and <code>1</code> (all equivalent to <code>true</code>) and <code>no</code>, <code>off</code>, and <code>0</code> (all equivalent to <code>false</code>).</p>
<h2 id="character-data-types-in-postgres">Character data types in Postgres</h2>
<table>
<thead>
<tr>
<th>Data type</th>
<th>Values allowed</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>character varying(n)</code>, <code>varchar(n)</code></td>
<td>Any characters, maximum length of n characters</td>
</tr>
<tr>
<td><code>character(n)</code>, <code>char(n)</code>, <code>bpchar(n)</code></td>
<td>Any characters, maximum length of n characters, blank-padded</td>
</tr>
<tr>
<td><code>bpchar</code></td>
<td>Any characters, no length limit, blank-trimmed</td>
</tr>
<tr>
<td><code>text</code></td>
<td>Any characters, no length limit</td>
</tr>
</tbody>
</table>
<p>All of these data types are used for storing strings. Generally speaking, <code>varchar(n)</code> is the right choice if you need to store strings that you know will remain constrained to a fixed length, and <code>text</code> is the right choice otherwise.</p>
<p>The difference between <code>char(n)</code> (and its aliases) and <code>varchar(n)</code> (and its aliases) is that <code>char(n)</code> is blank-padded, meaning that any strings with fewer than <code>n</code> characters will have spaces appended to the end until they reach <code>n</code> length.</p>
<p>So, for example, if we created two columns in a Postgres table, one with the data type <code>char(3)</code> and one <code>varchar(3)</code>, and then we added the string <code>hi</code> to a row in both columns, the <code>char(3)</code> column would store that as <code>hi </code> (with a space appended to the end to make it three characters), whereas the <code>varchar(3)</code> column would store it as <code>hi</code> (no spaces appended).</p>
<h2 id="numeric-data-types">Numeric data types</h2>
<h3 id="integer-data-types">Integer data types</h3>
<table>
<thead>
<tr>
<th>Data type</th>
<th>Size</th>
<th>Values allowed</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>smallint</code></td>
<td>2 bytes</td>
<td>-32768 to +32767</td>
</tr>
<tr>
<td><code>integer</code></td>
<td>4 bytes</td>
<td>-2147483648 to +2147483647</td>
</tr>
<tr>
<td><code>bigint</code></td>
<td>8 bytes</td>
<td>-9223372036854775808 to +9223372036854775807</td>
</tr>
</tbody>
</table>
<p>As you can see, all of these data types store integer values. The difference between them is the range of values they can store, and consequently the amount of storage space they take up.</p>
<p>For most use cases, <code>integer</code> is probably the right choice, but <code>smallint</code> will save space if you know your values will all fit in that range, and <code>bigint</code> is there for those who need to store truly massive numbers.</p>
<h3 id="auto-incrementing-number-data-types">Auto-incrementing number data types</h3>
<table>
<thead>
<tr>
<th>Data type</th>
<th>Size</th>
<th>Values allowed</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>smallserial</code></td>
<td>2 bytes</td>
<td>1 to 32767</td>
</tr>
<tr>
<td><code>serial</code></td>
<td>4 bytes</td>
<td>1 to 2147483647</td>
</tr>
<tr>
<td><code>bigserial</code></td>
<td>8 bytes</td>
<td>1 to 9223372036854775807</td>
</tr>
</tbody>
</table>
<p>These data types are all used to generate auto-incrementing numbers. Again, the only difference between them is the amount of space they take up, and again, there are specific <code>small</code> and <code>big</code> options, but <code>serial</code> is probably the best choice for most use cases.</p>
<h3 id="decimal-data-types">Decimal data types</h3>
<table>
<thead>
<tr>
<th>Data type</th>
<th>Size</th>
<th>Values allowed</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>decimal</code></td>
<td>variable</td>
<td>131,072 digits before the decimal point; 16,383 after it</td>
</tr>
<tr>
<td><code>numeric</code></td>
<td>variable</td>
<td>131,072 digits before the decimal point; 16,383 after it</td>
</tr>
<tr>
<td><code>real</code></td>
<td>4 bytes</td>
<td>6 decimal digits</td>
</tr>
<tr>
<td><code>double precision</code></td>
<td>8 bytes</td>
<td>15 decimal digits</td>
</tr>
</tbody>
</table>
<p>These data types all allow for the storage of numbers with decimals (i.e., not integers). <code>decimal</code> and <code>numeric</code> are the same, and should be used when precision is required, such as in financial applications. <code>real</code> and <code>double precision</code> take up less space, but also allow for fewer decimal places and thus may introduce imprecision, depending on the values you’re storing.</p>
<h2 id="time-and-date-data">Time and date data</h2>
<table>
<thead>
<tr>
<th>Data type</th>
<th>Size</th>
<th>Values allowed</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>timestamp</code> (and <code>timestamptz</code>)</td>
<td>8 bytes</td>
<td>4713 BCE to 294276 ACE</td>
</tr>
<tr>
<td><code>date</code></td>
<td>4 bytes</td>
<td>4713 BCE 5874897 ACE</td>
</tr>
<tr>
<td><code>time</code></td>
<td>8 bytes</td>
<td>00:00:00 to 24:00:00</td>
</tr>
<tr>
<td><code>timetz</code></td>
<td>12 bytes</td>
<td>00:00:00+1559 to 24:00:00-1559</td>
</tr>
<tr>
<td><code>interval</code></td>
<td>16 bytes</td>
<td>-178000000 years to 178000000 years</td>
</tr>
</tbody>
</table>
<p>These data types store time and duration data. Note that <code>timetz</code> and <code>timestamptz</code> can also be written as <code>time with timezone</code> and <code>timestamp with timezone</code>, respectively.</p>
<p>All time data types <em>except</em> <code>date</code> allow for microsecond-level precision, and can accept an optional provision value <code>p</code> (e.g. <code>timetz [(p)]</code>) to specify the number of fractional digits to store in the seconds field.</p>
<p><code>date</code>, for reasons that are probably obvious, stores values with a precision of one day.</p>
<p>Note also that in addition to traditional dates and times, <code>date</code> and <code>timestamp</code> can accept some special (and self-explanatory) values such as <code>now</code>, <code>yesterday</code>, <code>tomorrow</code>, etc. <code>now</code> will be stored as the current time; <code>yesterday</code>, <code>today</code>, and <code>tomorrow</code> are stored as 0:00 UTC on the relevant date.</p>
<h2 id="uuids">UUIDs</h2>
<p>The <code>uuid</code> data type is a special type of ID. We’ve got a whole blog post on <a href="https://www.cockroachlabs.com/blog/what-is-a-uuid/" >UUIDs with details on what they are, how they’re used, the different types of UUIDs, etc.</a>, so we won’t repeat all that here. The short version, however, is this: UUIDs provide ID values that are highly likely to be unique, which is useful for distributed systems (see that blog post for lots of details), or any system that is likely to merge new data at any point.</p>
<p>(Imagine, for example, your company has a database with sequential IDs using <code>serial</code>. You then acquire another company and need to merge the two databases, but discover the <em>other</em> company has also used <code>serial</code> IDs. Now you have a bit of a mess to sort out since you can’t have the same row ID for two separate rows, and each database will have a <code>1</code> row, a <code>2</code> row, etc. Conversely, if both databases used UUIDs, you could easily merge the two with essentially no chance that two rows could have the same id value.)</p>
<h2 id="json-data-types">JSON data types</h2>
<p>Postgres can store <a href="https://en.wikipedia.org/wiki/JSON" target="_blank" rel="noopener">JSON data</a> in two formats: <code>json</code> and <code>jsonb</code>.</p>
<p>These two formats are effectively identical, except that <code>jsonb</code> is stored in a decomposed binary format that makes it slower to write but faster to read. <code>jsonb</code> also supports indexing, whereas <code>json</code> does not.</p>
<h2 id="arrays">Arrays</h2>
<p>Postgres allows you to store most data types as arrays – in other words, lists of values of that data type. Arrays are declared using <code>[]</code>, so for example, here’s how to create a table of users that allows for multiple phone numbers to be input:</p>
<div class="highlight"><pre tabindex="0" style="color:#f8f8f2;background-color:#272822;-moz-tab-size:4;-o-tab-size:4;tab-size:4"><code class="language-sql" data-lang="sql"><span style="color:#66d9ef">CREATE</span> <span style="color:#66d9ef">TABLE</span> users (
	user_id uuid <span style="color:#66d9ef">PRIMARY</span> <span style="color:#66d9ef">KEY</span>,
	name TEXT
	phones TEXT []
);
</code></pre></div><p>Array values would be inserted into this table like so:</p>
<div class="highlight"><pre tabindex="0" style="color:#f8f8f2;background-color:#272822;-moz-tab-size:4;-o-tab-size:4;tab-size:4"><code class="language-sql" data-lang="sql"><span style="color:#66d9ef">INSERT</span> <span style="color:#66d9ef">INTO</span> users (name, phones)
<span style="color:#66d9ef">VALUES</span>(<span style="color:#e6db74">&#39;Ellen Ripley&#39;</span>, ARRAY [<span style="color:#e6db74">&#39;(555)-555-5555&#39;</span>,<span style="color:#e6db74">&#39;(555)-555-5556&#39;</span>]);
</code></pre></div><p>To declare array values, we can also use<code>{}</code> like so:</p>
<div class="highlight"><pre tabindex="0" style="color:#f8f8f2;background-color:#272822;-moz-tab-size:4;-o-tab-size:4;tab-size:4"><code class="language-sql" data-lang="sql"><span style="color:#66d9ef">INSERT</span> <span style="color:#66d9ef">INTO</span> users (name, phones)
<span style="color:#66d9ef">VALUES</span>(<span style="color:#e6db74">&#39;Ellen Ripley&#39;</span>, <span style="color:#e6db74">&#39;{“(555)-555-5555”,”(555)-555-5556”}’);
</span></code></pre></div><h2 id="special-data-types-in-postgres">Special data types in Postgres</h2>
<p>Postgres also contains quite a few other data types, although they’re typically only needed in specific circumstances. For example, the <code>tsvector</code> and <code>tsquery</code> data types store lexemes (words normalized such that different variants of the word are stored as one word). These data types are useful for efficient text search.</p>
<p>Postgres also provides specific data types for <a href="https://www.postgresql.org/docs/current/datatype-net-types.html" target="_blank" rel="noopener">network addresses</a>, <a href="https://www.postgresql.org/docs/current/datatype-geometric.html" target="_blank" rel="noopener">geometric shapes</a>, <a href="https://www.postgresql.org/docs/current/datatype-enum.html" target="_blank" rel="noopener">enumerated types</a>, <a href="https://www.postgresql.org/docs/current/datatype-xml.html" target="_blank" rel="noopener">XML types</a>, and more. There are also a number of <a href="https://www.postgresql.org/docs/current/datatype-pseudo.html" target="_blank" rel="noopener">pseudo-types</a>, which cannot be used as the data type for a column but can be used to define a function&rsquo;s argument or results.</p>
<h2 id="data-types-in-postgres-vs-cockroachdb">Data types in Postgres vs. CockroachDB</h2>
<p>CockroachDB is a distributed SQL database that’s Postgres compatible – imagine Postgres that was designed for the cloud, that auto-shards and can accept writes on every shard, and that can scale elastically. (<a href="https://www.cockroachlabs.com/" >Sound interesting? Check it out!</a>)</p>
<p>CockroachDB supports Postgres’s data types, although in some cases it uses different names. For example, <code>varchar</code> and <code>char</code> in PostgreSQL are equivalent to <code>STRING</code> in CockroachDB.</p>
<p>For the full list of data types in CockroachDB, <a href="https://www.cockroachlabs.com/docs/stable/data-types" >refer to our documentation.</a></p>
<p>Note also that because CockroachDB is a distributed database, the storage size and performance notes in this article may not be the same. Since CockroachDB is Postgres-compatible, migrating a Postgres database onto CockroachDB is quite straightforward, but some schema adjustment may be required to maximize performance (But don’t worry, we have an automated migration tool to help with this).</p>

      </div>

    
    <div class="row mb-4 mt-4">
      <div class="col-md-6 offset-md-4 col-lg-6 offset-lg-3">
  
        <ul class="nav nav-tags text-center">
          
              <li class="nav-item"><a class="nav-link mr-2 py-1 px-3" href="/tags/postgres">postgres</a></li>
         
              <li class="nav-item"><a class="nav-link mr-2 py-1 px-3" href="/tags/postgresql">postgresql</a></li>
         
        </ul>

        </div>
        </div>
        </div>
      </div>


  

  
    

        
        
                
            
            
            
            


                

                <div class="container">

                    <div class="row">          

                      <div class="col-md-8 offset-md-4 col-lg-6 offset-lg-3">

                        <h3 class="font-weight-bold h3 mb-0">About the author</h3>

                      </div>
  
                      <section class="mt-4">
  
                        <div class="col-md-8 offset-md-4 col-lg-6 offset-lg-3 author-box p-4">
            
                          <div class="col-md-12">

                            <h6 class="font-weight-bold mt-0">

                              <a href="https://www.cockroachlabs.com/blog/author/charlie-custer/">Charlie Custer</a>
                              

                              <a href="https://github.com/custerc" class="ml-2" role="button"><img src="https://crl2020.imgix.net/img/github-brands.png?auto=format,compress" class="github-icon blog-social-icon" alt="github link" width="20" height="20"/></a>
      
                              <a href="https://www.linkedin.com/in/charliecuster/" class="ml-2" role="button"><img src="https://crl2020.imgix.net/img/linkedin-brands.png?auto=format,compress" class="linkedin-icon blog-social-icon" alt="linkedin link" width="20" height="20"/></a> 

                            </h6>

                            <p>Charlie is a former teacher, tech journalist, and filmmaker who’s now combined those three professions into writing and making videos about databases and application development (and occasionally messing with NLP and Python to create weird things in his spare time).</p>
      
                      </div>

                    </div>

                </div>
                                
        </section>
                
    </div>
        
                

           

        
      


  





</div> 

<div class="light-bg py-6 mt-6 keep-reading-section">

    <div class="container">

        <div class="row row-eq-height">

        

            <h3 class="h2 mb-6">Keep Reading</h3>

	        

            <div class="col-md-4 mb-4 mb-md-0">

            <div class="card d-flex flex-column h-100">  

            

            <img src="https://crl2020.imgix.net/img/cockroach-db-vs-postgresql.png?auto=format,compress&fit=crop&w=395&h=185&q=65" width="395" height="185" loading="lazy" class="" />

            
            <div class="p-4 content">

            <a href="/blog/high-cpu-usage-postgres/"><h6 class="mt-4"><strong>High CPU usage in Postgres: how to detect it, and how to fix it</strong></h5></a>

            <p><p>High CPU usage can bring your database – and with it, your application – grinding to a halt.</p>
<p>This is, unfortunately, a …</p></p>

            <a href="/blog/high-cpu-usage-postgres/" class="btn btn-primary mt-4 stretched-link related-post-section-high-cpu-usage-in-postgres-how-to-detect-it-and-how-to-fix-it">Read more</a>

        </div>

    </div>

</div>

	

            <div class="col-md-4 mb-4 mb-md-0">

            <div class="card d-flex flex-column h-100">  

            

            <img src="https://crl2020.imgix.net/img/sql-fundamentals.png?auto=format,compress&fit=crop&w=395&h=185&q=65" width="395" height="185" loading="lazy" class="" />

            
            <div class="p-4 content">

            <a href="/blog/sql-cheat-sheet/"><h6 class="mt-4"><strong>SQL cheat sheet for developers, with examples (2023)</strong></h5></a>

            <p><p>Most SQL content on the web seems to be written with data analysts in mind. And that&rsquo;s fine, but developers need …</p></p>

            <a href="/blog/sql-cheat-sheet/" class="btn btn-primary mt-4 stretched-link related-post-section-sql-cheat-sheet-for-developers-with-examples-2023">Read more</a>

        </div>

    </div>

</div>

	

            <div class="col-md-4 mb-4 mb-md-0">

            <div class="card d-flex flex-column h-100">  

            

            <img src="https://crl2020.imgix.net/img/crl-stake-case-study-hero.png?auto=format,compress&fit=crop&w=395&h=185&q=65" width="395" height="185" loading="lazy" class="" />

            
            <div class="p-4 content">

            <a href="/blog/limitations-of-postgres/"><h6 class="mt-4"><strong>The limitations of PostgreSQL in financial services</strong></h5></a>

            <p><p>PostgreSQL has more than <a href="https://www.postgresql.org/about/" target="_blank" rel="noopener">35 years of active development</a> under its belt making it one of the most powerful and reliable …</p></p>

            <a href="/blog/limitations-of-postgres/" class="btn btn-primary mt-4 stretched-link related-post-section-the-limitations-of-postgresql-in-financial-services">Read more</a>

        </div>

    </div>

</div>

	

        </div>

    </div>

</div>

</div>







    
  
  
  <script>
    const svgCopy = '<svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true"><path fill-rule="evenodd" d="M0 6.75C0 5.784.784 5 1.75 5h1.5a.75.75 0 010 1.5h-1.5a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-1.5a.75.75 0 011.5 0v1.5A1.75 1.75 0 019.25 16h-7.5A1.75 1.75 0 010 14.25v-7.5z"></path><path fill-rule="evenodd" d="M5 1.75C5 .784 5.784 0 6.75 0h7.5C15.216 0 16 .784 16 1.75v7.5A1.75 1.75 0 0114.25 11h-7.5A1.75 1.75 0 015 9.25v-7.5zm1.75-.25a.25.25 0 00-.25.25v7.5c0 .138.112.25.25.25h7.5a.25.25 0 00.25-.25v-7.5a.25.25 0 00-.25-.25h-7.5z"></path></svg>';
    const svgCheck = '<svg aria-hidden="true" height="16" viewBox="0 0 16 16" version="1.1" width="16" data-view-component="true"><path fill-rule="evenodd" fill="rgb(25, 236, 222)" d="M13.78 4.22a.75.75 0 010 1.06l-7.25 7.25a.75.75 0 01-1.06 0L2.22 9.28a.75.75 0 011.06-1.06L6 10.94l6.72-6.72a.75.75 0 011.06 0z"></path></svg>';
    const addCopyButtons = (clipboard) => {
    	document.querySelectorAll("pre > code").forEach((codeBlock) => {
    		const button = document.createElement("button");
    		button.className = "clipboard-button";
    		button.type = "button";
    		button.innerHTML = svgCopy;
    		button.addEventListener("click", () => {
    			clipboard.writeText(codeBlock.innerText).then(
    				() => {
    					button.blur();
    					button.innerHTML = svgCheck;
    					setTimeout(() => (button.innerHTML = svgCopy), 2000);
    				}, (error) => (button.innerHTML = "Error"));
    		});
    		const pre = codeBlock.lastChild;
    		pre.parentNode.insertBefore(button, pre);
    	});
    };
    if (navigator && navigator.clipboard) {
    	addCopyButtons(navigator.clipboard);
    } else {
    	const script = document.createElement("script");
    	script.src = "https://cdnjs.cloudflare.com/ajax/libs/clipboard-polyfill/2.7.0/clipboard-polyfill.promise.js";
    	script.integrity = "sha256-waClS2re9NUbXRsryKoof+F9qc1gjjIhc2eT7ZbIv94=";
    	script.crossOrigin = "anonymous";
    	script.onload = () => addCopyButtons(clipboard);
    	document.body.appendChild(script);
    }
  </script>
  
<style>.highlight,pre{position:relative}pre:hover .clipboard-button{opacity:1}.clipboard-button{position:absolute;right:0;padding:2px 7px 5px;margin:5px;color:#653dfe;background-color:#f5f7fa;border:1px solid transparent;border-radius:6px;font-size:.8em;z-index:1;transition:.5s;top:2px;opacity:0}.clipboard-button>svg{fill:#653dfe}.clipboard-button:hover{cursor:pointer}.clipboard-button:hover>svg{fill:#419af7}.clipboard-button:focus{outline:0}</style>
  



    
<footer class="main-footer
">
  <div class="container">
    <div class="row">
      <div class="col-md-3" id="footer-1">
        <h4 class="footer-menu-title">Product</h4>

        <ul>
          <li>
            <a href="/product/" class="footer-link"> CockroachDB </a>
          </li>

          <li>
            <a href="/product/" class="footer-link"> CockroachDB Dedicated </a>
          </li>

          <li>
            <a href="/pricing/" class="footer-link"> Pricing </a>
          </li>

          <li>
            <a href="/get-started-cockroachdb/" class="footer-link"> Get CockroachDB </a>
          </li>

          <li>
            <a href="https://cockroachlabs.cloud/" class="footer-link"> Sign In </a>
          </li>
          <li>
            <a href="https://www.cockroachlabs.com/docs/stable/install-cockroachdb" class="footer-link"> Download</a>
          </li>
        </ul>
      </div>

      <div class="col-md-3" id="footer-2">
        <h4 class="footer-menu-title">Resources</h4>

        <ul>
          <li>
            <a href="https://resources.cockroachlabs.com/guides/" class="footer-link"> Guides </a>
          </li>

          <li>
            <a href="/community/webinars/" class="footer-link"> Video & Webinars </a>
          </li>

          <li>
            <a href="/big-ideas-podcast/" class="footer-link"> Podcast </a>
          </li>

          <li>
            <a href="/compare/"  class="footer-link">Compare</a>
          </li>
          <li>
            <a href="https://www.cockroachlabs.com/docs/stable/architecture/overview" class="footer-link"> Architecture Overview </a>
          </li>

          <li>
            <a href="https://www.cockroachlabs.com/docs/stable/frequently-asked-questions" class="footer-link"> FAQ </a>
          </li>

          <li>
            <a href="/security/" class="footer-link"> Security </a>
          </li>
        </ul>
      </div>

      <div class="col-md-3" id="footer-3">
        <h4 class="footer-menu-title">Learn more</h4>

        <ul>
          <li>
            <a href="https://www.cockroachlabs.com/docs/stable/" class="footer-link"> Docs </a>
          </li>

          <li>
            <a href="/cockroach-university/" class="footer-link"> University </a>
          </li>

          <li>
            <a href="https://github.com/cockroachdb" class="footer-link"> GitHub </a>
          </li>

        </ul>

        <br />

        <h4 class="footer-menu-title">Support Channels</h4>

        <ul>
          <li>
            <a href="https://forum.cockroachlabs.com/" class="footer-link"> Forum </a>
          </li>

          <li>
            <a href="https://www.cockroachlabs.com/join-community/" class="footer-link"> Slack </a>
          </li>

          <li>
            <a href="https://support.cockroachlabs.com/hc/" class="footer-link"> Support Portal </a>
          </li>

          <li>
            <a href="/contact/" class="footer-link"> Contact us </a>
          </li>
        </ul>
      </div>

      <div class="col-md-3" id="footer-4">
        <h4 class="footer-menu-title">Company</h4>

        <ul>
          <li>
            <a href="/about/" class="footer-link"> About </a>
          </li>

          <li>
            <a href="/featured-blog/" class="footer-link"> Blog </a>
          </li>

          <li>
            <a href="/careers/" class="footer-link"> Careers </a>
          </li>

          <li>
            <a href="/customers/" class="footer-link"> Customers </a>
          </li>

          <li>
            <a href="/partners/" class="footer-link"> Partners </a>
          </li>

          <li>
            <a href="/events/" class="footer-link"> Events </a>
          </li>

          <li>
            <a href="/press/" class="footer-link"> News </a>
          </li>

          <li>
            <a href="/trust-center/" class="footer-link"> Trust </a>
          </li>
          
          <li>
            <a href="/privacy/" class="footer-link"> Privacy </a>
          </li>
          
          <li>
            <a href="/legal-notices/" class="footer-link"> Legal Notices </a>
          </li>
          
        </ul>
      </div>
    </div>
  </div>
</footer>


    







<script src="https://cookie-cdn.cookiepro.com/scripttemplates/otSDKStub.js"  type="text/javascript" charset="UTF-8" data-domain-script="983b37b4-06dd-4d5e-adb4-74b227c791ab" ></script>
<script type="text/javascript">
function OptanonWrapper() { }
</script>



<script type="text/plain" class="optanon-category-2">
  !function(s,a,e,v,n,t,z){if(s.saq)return;n=s.saq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!s._saq)s._saq=n;n.push=n;n.loaded=!0;n.version='1.0';n.queue=[];t=a.createElement(e);t.async=0;t.src=v;z=a.getElementsByTagName(e)[0];z.parentNode.insertBefore(t,z)}(window,document,'script','https://tags.srv.stackadapt.com/events.js');saq('ts','Zl8UXgMNSfOzEII0jDO9NQ');
</script>




<script type="text/javascript">
  (function() {
    var didInit = false;
    function initMunchkin() {
      if(didInit === false) {
        didInit = true;
        Munchkin.init('350-QIN-827');
      }
    }
    var s = document.createElement('script');
    s.type = 'text/javascript';
    s.async = true;
    s.src = '//munchkin.marketo.net/munchkin.js';
    s.onreadystatechange = function() {
      if (this.readyState == 'complete' || this.readyState == 'loaded') {
        initMunchkin();
      }
    };
    s.onload = initMunchkin;
    document.getElementsByTagName('head')[0].appendChild(s);
  })();
  </script>


    
    
      <script src="/main.js"></script>
    
    <link rel="stylesheet" href="/css/katex.min.css">
  
<script async id="netlify-rum-container" src="https://netlify-rum.netlify.app/netlify-rum.js" data-netlify-rum-site-id="dc444f77-e72a-4e8b-b364-d5904ea311de" data-netlify-deploy-branch="master" data-netlify-deploy-context="production" data-netlify-cwv-token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzaXRlX2lkIjoiZGM0NDRmNzctZTcyYS00ZThiLWIzNjQtZDU5MDRlYTMxMWRlIiwiYWNjb3VudF9pZCI6IjViNGY5Y2FkYzZhZWQ2NDFlZDc4NDc3YSIsImRlcGxveV9pZCI6IjY1YTk5OWYzZDk1MjNmMDAwODQwNzZmYiIsImlzc3VlciI6Im5mc2VydmVyIn0.quB46EKQFs2bPE6LU__IYEFEgNcDl1YAST9aCCfr2dc"></script></body>
</html>
EOF
)

curl http://localhost:11434/api/pull -d '{
  "name": "llama2"
}'

curl http://localhost:11434/api/generate -d '{
	"model": "llama2",
	"format": "json",
	"stream": false,
	"prompt": "Summarize the following blog post:\n $html_content"
}'