use std::path::Path;

fn main() -> anyhow::Result<()> {
    // GO
    gobuild::Build::new()
        .file(concat!(env!("CARGO_MANIFEST_DIR"), "/go/cmd/main.go"))
        .buildmode(gobuild::BuildMode::CArchive)
        .compile("goffi");

    bindgen::Builder::default()
        .header(Path::new(&std::env::var("OUT_DIR")?).join("libgoffi.h").to_string_lossy().into_owned())
        .parse_callbacks(Box::new(bindgen::CargoCallbacks::new()))
        .generate()
        .expect("Unable to generate bindings")
        .write_to_file(Path::new(&std::env::var("OUT_DIR")?).join("bindings.rs"))
        .expect("Couldn't write bindings!");

    cc::Build::new()
        .cuda(true)
        .flag("-allow-unsupported-compiler")
        .opt_level(3)
        .cudart("static")
        .file(concat!(env!("CARGO_MANIFEST_DIR"), "/../cmake/src/kernel.cu"))
        .compile("libkernel.a");

    println!("cargo:rerun-if-changed=go/cmd/main.go");
    println!("cargo:rerun-if-changed=cmake/src/kernel.cu");
    println!("cargo:rerun-if-changed=cmake/src/kernel.h");
    println!("cargo:rerun-if-changed=cmake/CMakeLists.txt");

    // CMake
    // NOTE: somehow this will not work for cuda
    // let dst = cmake::Config::new("../cmake")
    //     .define("GOOGLE_TEST", "OFF")
    //     .build_target("all")
    //     .build();
    //
    // println!("cargo:warning=cmake build dir: {:?}", dst);
    // println!("cargo:rustc-link-search=native={}/build/lib", dst.display());
    // println!("cargo:rustc-link-lib=static=App");

    Ok(())
}
