//= require jquery
//= require jquery_ujs

document.addEventListener("DOMContentLoaded",function(){
  const ImageList = document.getElementById("image-list");
  if (!ImageList){ return false;}
  document.getElementById("post_img").addEventListener("change", function(e){
   const imageContent = document.querySelector('img');
   if (imageContent){
     imageContent.remove();
   }

   const file = e.target.files[0];
   const blob = window.URL.createObjectURL(file);

   const imageElement =  document.createElement('div');
   const blobImage = document.createElement('img');
   blobImage.setAttribute('src', blob);
  blobImage.classList.add('preview-size');
  imageElement.appendChild(blobImage);
  ImageList.appendChild(imageElement);
  });
});