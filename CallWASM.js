async function run() {
    const bytes = await fetch("W.wasm").then(r => r.arrayBuffer());

    const { instance } = await WebAssembly.instantiate(bytes);

    console.log(instance.exports.answer());
}

run();