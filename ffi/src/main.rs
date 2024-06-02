use std::ffi::CStr;

mod bindings {
    #![allow(
        unused,
        non_upper_case_globals,
        non_camel_case_types,
        non_snake_case,
        // Silence "128-bit integers don't currently have a known stable ABI" warnings
        improper_ctypes,
        // Silence "constants have by default a `'static` lifetime" clippy warnings
        clippy::redundant_static_lifetimes,
        // https://github.com/rust-lang/rust-bindgen/issues/1651
        deref_nullptr,
    )]
    include!(concat!(env!("OUT_DIR"), "/bindings.rs"));
}

extern "C" {
    fn runKernel();
}

fn main() {
    println!("{}", unsafe {
        let c_str = bindings::HelloWorld();
        let rs_str = CStr::from_ptr(c_str).to_string_lossy().into_owned();
        libc::free(c_str as *mut libc::c_void);
        rs_str
    });

    unsafe {
        runKernel()
    }
}
