//<I HATE JS>
// my teacher carryed me with js
const form = document.createElement("form");
form.method = "POST";
form.className = "B"

function getCookie(name) {
  return document.cookie
    .split("; ")
    .find(row => row.startsWith(name + "="))
    ?.split("=")[1] ?? null;
}

const raw = getCookie("6");

if (!raw) {
  console.error("Cookie '6' is missing or not accessible");
  throw new Error("Missing tile data");
}
const tiles = [];

for (let i = 0; i < 2500; i += 2) {
  tiles.push(raw.slice(i, i + 2));
}

const container = document.body;

tiles.forEach((id, idx) => {
  const t = document.createElement("t");

  const x = idx % 50;
  const y = Math.floor(idx / 50);
  t.setAttribute(
    "name","8"
  );
  t.setAttribute(
    "value",
    String(x).padStart(2, "0") +
    String(y).padStart(2, "0")
  );

  t.style.position = "absolute";
  t.style.left = x * 2 + "vw";
  t.style.top = y * 4 + "vh";
  
  t.style.backgroundImage = `url(/img/a${id}.bmp)`;

  form.appendChild(t);
});


const raw2 = getCookie("8");

if (!raw2) {
  console.error("Cookie '6' is missing or not accessible");
  throw new Error("Missing tile data");
}
const tiles2 = [];

for (let i = 0; i < 2498; i += 2) {
  tiles2.push(raw2.slice(i, i + 2));
}

// const container2 = document.body;



tiles2.forEach((id, idx) => {
  if (id != "00") {
    const t = document.createElement("t");

    const x = idx % 50;
    const y = Math.floor(idx / 50);

    t.setAttribute(
      "name","8"
    );
    t.setAttribute(
      "value",
      String(x).padStart(2, "0") +
      String(y).padStart(2, "0")
    );

    t.style.position = "absolute";
    t.style.left = x * 2 + "vw";
    t.style.top = y * 4 + "vh";

    t.style.backgroundImage = `url(/img/b${id}.bmp)`;

    form.appendChild(t);
  }
});

container.appendChild(form);
//i hate java script

document.addEventListener("click", (e) => {
  const tile = e.target.closest("t");
  if (!tile) return;

  const form = document.querySelector("form.B");

  form.querySelector('input[name="8"]')?.remove();

  const input = document.createElement("input");
  input.type = "hidden";
  input.name = "8";
  input.value = tile.getAttribute("value");

  form.appendChild(input);

  form.requestSubmit(); 
});
//</I HATE JS>
