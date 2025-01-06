<!doctype html>
<html lang="en">
   <head>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta name="description" content="Askbootstrap">
      <meta name="author" content="Askbootstrap">
      <title>Osahan Eat - Online Food Ordering Website HTML Template</title>
      <!-- Favicon Icon -->
      <link rel="icon" type="image/png" href="img/favicon.png">
    <!-- Bootstrap core CSS-->
<link href="{{ asset('frontend/vendor/bootstrap/css/bootstrap.min.css') }}" rel="stylesheet">
<!-- Font Awesome-->
<link href="{{ asset('frontend/vendor/fontawesome/css/all.min.css') }}" rel="stylesheet">
<!-- IcoFont -->
<link href="{{ asset('frontend/vendor/icofont/icofont.min.css') }}" rel="stylesheet">
<!-- Select2 CSS -->
<link href="{{ asset('frontend/vendor/select2/css/select2.min.css') }}" rel="stylesheet">
<!-- Custom styles for this template -->
<link href="{{ asset('frontend/css/osahan.css') }}" rel="stylesheet">
<!-- Owl Carousel -->
<link rel="stylesheet" href="{{ asset('frontend/vendor/owl-carousel/owl.carousel.css') }}">
<link rel="stylesheet" href="{{ asset('frontend/vendor/owl-carousel/owl.theme.css') }}">

   </head>
   <body>
      <div class="homepage-header">
      <div class="overlay"></div>
    @include('frontend.layouts.header')
    @include('frontend.layouts.banner')

      </div>
      @include('frontend.layouts.ads')

      @yield('content')



    @include('frontend.layouts.member')

    @include('frontend.layouts.footer')

      <footer class="pt-4 pb-4 text-center">
         <div class="container">
            <p class="mt-0 mb-0">© Copyright 2020 Osahan Eat. All Rights Reserved</p>
            <small class="mt-0 mb-0"> Made with <i class="fas fa-heart heart-icon text-danger"></i> by
            <a class="text-danger" target="_blank" href="https://www.instagram.com/iamgurdeeposahan/">Gurdeep Osahan</a> - <a class="text-primary" target="_blank" href="https://askbootstrap.com/">Ask Bootstrap</a>
            </small>
         </div>
      </footer>
      <!-- jQuery -->
      <script src="{{asset('frontend/vendor/jquery/jquery-3.3.1.slim.min.js')"></script>
      <!-- Bootstrap core JavaScript-->
      <script src="{{asset('vendor/bootstrap/js/bootstrap.bundle.min.js')"></script>
      <!-- Select2 JavaScript-->
      <script src="{{asset('frontend/vendor/select2/js/select2.min.js')"></script>
      <!-- Owl Carousel -->
      <script src="{{asset('frontend/vendor/owl-carousel/owl.carousel.js')"></script>
      <!-- Custom scripts for all pages-->
      <script src="{{asset('frontend/js/custom.js')"></script>
   </body>
</html>
