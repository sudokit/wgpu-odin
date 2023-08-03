package wgpu

// Core
import "core:fmt"
import "core:mem"
import "core:reflect"

// Package
import wgpu "../bindings"

// Force backend type option
WGPU_BACKEND_TYPE :: #config(WGPU_BACKEND_TYPE, "Undefined")

// Context for all other wgpu objects.
Instance :: struct {
    ptr:          WGPU_Instance,
    using vtable: ^Instance_VTable,
}

@(private)
Instance_VTable :: struct {
    create_surface:     proc(
        self: ^Instance,
        options: ^Surface_Descriptor,
    ) -> (
        Surface,
        Error_Type,
    ),
    request_adapter:    proc(
        self: ^Instance,
        options: ^Request_Adapter_Options,
    ) -> (
        Adapter,
        Error_Type,
    ),
    enumerate_adapters: proc(
        self: ^Instance,
        backends: Instance_Backend_Flags,
        allocator: mem.Allocator = context.allocator,
    ) -> []Adapter,
    generate_report:    proc(self: ^Instance) -> Global_Report,
    print_report:       proc(self: ^Instance),
    release:            proc(self: ^Instance),
}

@(private)
default_instance_vtable := Instance_VTable {
    create_surface     = instance_create_surface,
    request_adapter    = instance_request_adapter,
    enumerate_adapters = instance_enumerate_adapters,
    generate_report    = instance_generate_report,
    print_report       = instance_print_report,
    release            = instance_release,
}

@(private)
default_instance := Instance {
    ptr    = nil,
    vtable = &default_instance_vtable,
}

// Options for creating an instance.
Instance_Descriptor :: struct {
    backends:             Instance_Backend_Flags,
    dx12_shader_compiler: Dx12_Compiler,
    dxil_path:            cstring,
    dxc_path:             cstring,
}

// Backends are set to `Primary`, and `FXC` is chosen as the `dx12_shader_compiler`.
Instance_Descriptor_Default :: Instance_Descriptor {
    backends             = wgpu.Instance_Backend_Primary,
    dx12_shader_compiler = .Fxc,
}
Dx12_Compiler_Default :: Dx12_Compiler.Fxc

// Create an new instance of wgpu.
create_instance :: proc(options: ^Instance_Descriptor = nil) -> Instance {
    descriptor := wgpu.Instance_Descriptor {
        next_in_chain = nil,
    }

    if options != nil {
        instance_extras := Instance_Extras {
            chain = {next = nil, stype = cast(SType)Native_SType.Instance_Extras},
            backends = options.backends,
            dx12_shader_compiler = options.dx12_shader_compiler,
            dxil_path = options.dxil_path,
            dxc_path = options.dxc_path,
        }

        descriptor.next_in_chain = cast(^Chained_Struct)&instance_extras
    }

    instance := default_instance
    instance.ptr = wgpu.create_instance(&descriptor)

    if instance.ptr == nil {
        panic("Failed to acquire Instance")
    }

    return instance
}

Surface_Descriptor :: struct {
    label:                 cstring,
    Android_Native_Window: ^Surface_Descriptor_From_Android_Native_Window,
    Html_Selector:         ^Surface_Descriptor_From_Canvas_Html_Selector,
    Metal_Layer:           ^Surface_Descriptor_From_Metal_Layer,
    Wayland_Surface:       ^Surface_Descriptor_From_Wayland_Surface,
    Windows_HWND:          ^Surface_Descriptor_From_Windows_HWND,
    Xcb_Window:            ^Surface_Descriptor_From_Xcb_Window,
    Xlib_Window:           ^Surface_Descriptor_From_Xlib_Window,
}

// Creates a surface from a window handle.
instance_create_surface :: proc(
    using self: ^Instance,
    descriptor: ^Surface_Descriptor,
) -> (
    Surface,
    Error_Type,
) {
    desc := wgpu.Surface_Descriptor{}

    if descriptor != nil {
        desc.label = descriptor.label

        if descriptor.Windows_HWND != nil {
            if desc.label == nil || desc.label == "" {
                desc.label = "Windows HWND"
            }

            desc.next_in_chain =
            cast(^Chained_Struct)&Surface_Descriptor_From_Windows_HWND{
                chain = Chained_Struct{
                    next = nil,
                    stype = .Surface_Descriptor_From_Windows_HWND,
                },
                hinstance = descriptor.Windows_HWND.hinstance,
                hwnd = descriptor.Windows_HWND.hwnd,
            }
        } else if descriptor.Xcb_Window != nil {
            if desc.label == nil || desc.label == "" {
                desc.label = "XCB Window"
            }

            desc.next_in_chain =
            cast(^Chained_Struct)&Surface_Descriptor_From_Xcb_Window{
                chain = Chained_Struct{
                    next = nil,
                    stype = .Surface_Descriptor_From_Xcb_Window,
                },
                connection = descriptor.Xcb_Window.connection,
                window = descriptor.Xcb_Window.window,
            }
        } else if descriptor.Xlib_Window != nil {
            if desc.label == nil || desc.label == "" {
                desc.label = "X11 Window"
            }

            desc.next_in_chain =
            cast(^Chained_Struct)&Surface_Descriptor_From_Xlib_Window{
                chain = Chained_Struct{
                    next = nil,
                    stype = .Surface_Descriptor_From_Xlib_Window,
                },
                display = descriptor.Xlib_Window.display,
                window = descriptor.Xlib_Window.window,
            }
        } else if descriptor.Metal_Layer != nil {
            if desc.label == nil || desc.label == "" {
                desc.label = "Metal Layer"
            }

            desc.next_in_chain =
            cast(^Chained_Struct)&Surface_Descriptor_From_Metal_Layer{
                chain = Chained_Struct{
                    next = nil,
                    stype = .Surface_Descriptor_From_Metal_Layer,
                },
                layer = descriptor.Metal_Layer.layer,
            }
        } else if descriptor.Wayland_Surface != nil {
            if desc.label == nil || desc.label == "" {
                desc.label = "Wayland Surface"
            }

            desc.next_in_chain =
            cast(^Chained_Struct)&Surface_Descriptor_From_Wayland_Surface{
                chain = Chained_Struct{
                    next = nil,
                    stype = .Surface_Descriptor_From_Wayland_Surface,
                },
                display = descriptor.Wayland_Surface.display,
                surface = descriptor.Wayland_Surface.surface,
            }
        } else if descriptor.Android_Native_Window != nil {
            if desc.label == nil || desc.label == "" {
                desc.label = "Android Native Window"
            }

            desc.next_in_chain =
            cast(^Chained_Struct)&Surface_Descriptor_From_Android_Native_Window{
                chain = Chained_Struct{
                    next = nil,
                    stype = .Surface_Descriptor_From_Android_Native_Window,
                },
                window = descriptor.Android_Native_Window.window,
            }
        } else {
            fmt.eprintf("Cannot get surface id: unsupported WGPU surface type.\n")
            return {}, .Unknown
        }
    }

    surface_ptr := wgpu.instance_create_surface(ptr, &desc)

    if surface_ptr == nil {
        fmt.eprintf("Failed to acquire surface\n")
        return {}, .Internal
    }

    surface := default_surface
    surface.ptr = surface_ptr

    return surface, .No_Error
}

Adapter_Response :: struct {
    status:  Request_Adapter_Status,
    message: cstring,
    adapter: WGPU_Adapter,
}

Power_Preference_Default: Power_Preference = .High_Performance

Request_Adapter_Options :: struct {
    compatible_surface:     ^Surface,
    power_preference:       Power_Preference,
    backend_type:           Backend_Type,
    force_fallback_adapter: bool,
}

// Retrieves an `Adapter` which matches the given parameters.
instance_request_adapter :: proc(
    using self: ^Instance,
    options: ^Request_Adapter_Options,
) -> (
    Adapter,
    Error_Type,
) {
    opts := wgpu.Request_Adapter_Options{}

    if options != nil {
        if options.compatible_surface != nil {
            opts.compatible_surface = options.compatible_surface.ptr
        }

        opts.power_preference = options.power_preference
        opts.force_fallback_adapter = options.force_fallback_adapter
        opts.backend_type = .Undefined

        // Try to read WGPU_BACKEND_TYPE config to see if a backend type should be forced
        if WGPU_BACKEND_TYPE != "" &&
           WGPU_BACKEND_TYPE != "Undefined" &&
           WGPU_BACKEND_TYPE != "Null" {
            // Try to get the backend type from the string configuration
            backend, backend_ok := reflect.enum_from_name(
                Backend_Type,
                WGPU_BACKEND_TYPE,
            )

            if backend_ok {
                opts.backend_type = backend
            } else {
                fmt.eprintf(
                    "Backend type [%v] is invalid, possible values are (case sensitive): \n\tWebGPU\n\tD3D11\n\tD3D12\n\tMetal\n\tVulkan\n\tOpenGL\n\tOpenGLES\n\n",
                    WGPU_BACKEND_TYPE,
                )

                return {}, .Validation
            }
        } else {
            // By default force Vulkan on Windows if none is given
            when ODIN_OS == .Windows {
                opts.backend_type = .Vulkan
            }
        }
    }

    res := Adapter_Response{}
    wgpu.instance_request_adapter(ptr, &opts, _on_request_adapter_callback, &res)

    if res.status != .Success {
        fmt.eprintf("Failed to request adapter: [%v] - %s\n", res.status, res.message)
        return {}, .Internal
    }

    adapter := default_adapter
    adapter.ptr = res.adapter
    adapter.features = adapter->get_features()
    adapter.limits, adapter.limits_extras = adapter->get_limits()
    adapter.info = adapter->request_info()

    return adapter, .No_Error
}

// Retrieves all available `Adapters` that match the given options.
instance_enumerate_adapters :: proc(
    using self: ^Instance,
    backends: Instance_Backend_Flags,
    allocator := context.allocator,
) -> []Adapter {
    options := Instance_Enumerate_Adapter_Options {
        backends = backends,
    }

    adapter_count: uint = wgpu.instance_enumerate_adapters(ptr, &options, nil)

    if adapter_count == 0 {
        fmt.print("No compatible adapter found!\n")
        return {}
    }

    wgpu_adapters := make([]WGPU_Adapter, adapter_count, allocator)
    defer delete(wgpu_adapters)
    wgpu.instance_enumerate_adapters(ptr, &options, raw_data(wgpu_adapters))

    adapters := make([]Adapter, adapter_count, allocator)

    for i: uint = 0; i < adapter_count; i += 1 {
        adapters[i] = {
            ptr    = wgpu_adapters[i],
            vtable = &default_adapter_vtable,
        }

        adapters[i].features = adapters[i]->get_features()
        adapters[i].limits, adapters[i].limits_extras = adapters[i]->get_limits()
        adapters[i].info = adapters[i]->request_info()
    }

    return adapters
}

// Generates memory report.
instance_generate_report :: proc(self: ^Instance) -> Global_Report {
    report: Global_Report = {}
    wgpu.generate_report(self.ptr, &report)
    return report
}

// Print memory report.
instance_print_report :: proc(using self: ^Instance) {
    report := self->generate_report()

    print_storage_report :: proc(report: Storage_Report, prefix: cstring) {
        fmt.printf("\t%snum_occupied = %d\n", prefix, report.num_occupied)
        fmt.printf("\t%snum_vacant = %d\n", prefix, report.num_vacant)
        fmt.printf("\t%snum_error = %d\n", prefix, report.num_error)
        fmt.printf("\t%selement_size = %d\n", prefix, report.element_size)
    }

    print_hub_report :: proc(report: Hub_Report, prefix: cstring) {
        print_storage_report(report.adapters, "adapters.")
        print_storage_report(report.devices, "devices.")
        print_storage_report(report.pipeline_layouts, "pipeline_layouts.")
        print_storage_report(report.shader_modules, "shader_modules.")
        print_storage_report(report.bind_group_layouts, "bind_group_layouts.")
        print_storage_report(report.bind_groups, "bind_groups.")
        print_storage_report(report.command_buffers, "command_buffers.")
        print_storage_report(report.render_bundles, "render_bundles.")
        print_storage_report(report.render_pipelines, "render_pipelines.")
        print_storage_report(report.compute_pipelines, "compute_pipelines.")
        print_storage_report(report.query_sets, "query_sets.")
        print_storage_report(report.textures, "textures.")
        print_storage_report(report.texture_views, "texture_views.")
        print_storage_report(report.samplers, "samplers.")
    }

    fmt.print("struct Global_Report {\n")

    print_storage_report(report.surfaces, "surfaces.")

    #partial switch report.backend_type {
    case .D3D11:
        print_hub_report(report.dx11, "dx11.")
    case .D3D12:
        print_hub_report(report.dx12, "dx12.")
    case .Metal:
        print_hub_report(report.metal, "metal.")
    case .Vulkan:
        print_hub_report(report.vulkan, "vulkan.")
    case .OpenGL:
        print_hub_report(report.gl, "gl.")
    case:
        fmt.printf("%s - Invalid backend type: %v", #procedure, report.backend_type)
    }

    fmt.print("}\n\n")
}

// Release instance.
instance_release :: proc(using self: ^Instance) {
    if ptr != nil do wgpu.instance_release(ptr)
}

@(private)
_on_request_adapter_callback :: proc "c" (
    status: Request_Adapter_Status,
    adapter: WGPU_Adapter,
    message: cstring,
    user_data: rawptr,
) {
    response := cast(^Adapter_Response)user_data
    response.status = status
    response.message = message

    if status == .Success {
        response.adapter = adapter
    }
}