<script>
window.onload = () => {
    const img5 = document.getElementById('img5');
    const img4 = document.getElementById('img4');
    const img3 = document.getElementById('img3');
    const img2 = document.getElementById('img2');

    img5.style.transition = 'top 0.6s linear';
    img4.style.transition = 'top 0.6s linear';
    img3.style.transition = 'top 1s linear';
    img2.style.transition = 'top 0.8s linear';

    setTimeout(() => {
        img5.style.top = 'calc(50% - 270px)';
        img4.style.top = 'calc(50% + 110px)';
        img3.style.top = 'calc(50% - 160px)';
        img2.style.top = '50%';
    }, 50);

    img3.addEventListener("mouseenter", () => {
        img3.style.backgroundImage = "url('/img/6.bmp')";
    });
    img3.addEventListener("mouseleave", () => {
        img3.style.backgroundImage = "url('/img/3.bmp')";
    });

    img4.addEventListener("mouseenter", () => {
        img4.style.backgroundImage = "url('/img/8.bmp')";
    });
    img4.addEventListener("mouseleave", () => {
       img4.style.backgroundImage = "url('/img/4.bmp')";
    });

    img2.addEventListener("mouseenter", () => {
        img2.style.backgroundImage = "url('/img/7.bmp')";
    });
    img2.addEventListener("mouseleave", () => {
        img2.style.backgroundImage = "url('/img/2.bmp')";
    });
};

</script>