package tutorial4_buffer_challenge

// Core
import "core:fmt"
import "core:runtime"
import "core:math"

// Vendor
import sdl "vendor:sdl2"

// Package
import wgpu "../../../../wrapper"
import wgpu_sdl "../../../../utils/sdl"

Vertex :: struct {
    position: [3]f32,
    color:    [3]f32,
}

State :: struct {
    minimized:               bool,
    surface:                 wgpu.Surface,
    swap_chain:              wgpu.Swap_Chain,
    device:                  wgpu.Device,
    config:                  wgpu.Surface_Configuration,
    render_pipeline:         wgpu.Render_Pipeline,
    vertex_buffer:           wgpu.Buffer,
    index_buffer:            wgpu.Buffer,
    challenge_vertex_buffer: wgpu.Buffer,
    challenge_index_buffer:  wgpu.Buffer,
    num_indices:             u32,
    num_challenge_indices:   u32,
    use_complex:             bool,
}

Physical_Size :: struct {
    width:  u32,
    height: u32,
}

_log_callback :: proc "c" (level: wgpu.Log_Level, message: cstring, user_data: rawptr) {
    context = runtime.default_context()
    fmt.eprintf("[wgpu] [%v] %s\n\n", level, message)
}

@(init)
init :: proc() {
    wgpu.set_log_callback(_log_callback, nil)
    wgpu.set_log_level(.Warn)
}

init_state := proc(window: ^sdl.Window) -> (s: State, err: wgpu.Error_Type) {
    state := State{}

    instance_descriptor := wgpu.Instance_Descriptor {
        backends             = wgpu.Instance_Backend_Primary,
        dx12_shader_compiler = wgpu.Dx12_Compiler_Default,
    }

    instance := wgpu.create_instance(&instance_descriptor) or_return
    defer instance->release()

    surface_descriptor := wgpu_sdl.get_surface_descriptor(window) or_return
    state.surface = instance->create_surface(&surface_descriptor) or_return
    defer if err != .No_Error do state.surface->release()

    adapter_options := wgpu.Request_Adapter_Options {
        power_preference       = .High_Performance,
        compatible_surface     = &state.surface,
        force_fallback_adapter = false,
    }

    adapter := instance->request_adapter(&adapter_options) or_return
    defer adapter->release()

    device_descriptor := wgpu.Device_Descriptor {
        label  = adapter.info.name,
        limits = wgpu.Default_Limits,
    }

    state.device = adapter->request_device(&device_descriptor) or_return
    defer if err != .No_Error do state.device->release()

    caps := state.surface->get_capabilities(adapter) or_return
    defer {
        delete(caps.formats)
        delete(caps.present_modes)
        delete(caps.alpha_modes)
    }

    width, height: i32
    sdl.GetWindowSize(window, &width, &height)

    surface_format := state.surface->get_preferred_format(&adapter)

    state.config = {
        usage = {.Render_Attachment},
        format = surface_format,
        width = cast(u32)width,
        height = cast(u32)height,
        present_mode = .Fifo,
        alpha_mode = caps.alpha_modes[0],
    }

    state.swap_chain = state.device->create_swap_chain(
        &state.surface,
        &state.config,
    ) or_return
    defer if err != .No_Error do state.swap_chain->release()

    shader := state.device->load_wgsl_shader_module(
        "assets/learn_wgpu/tutorial4/shader.wgsl",
        "shader.wgsl",
    ) or_return
    defer shader->release()

    render_pipeline_layout := state.device->create_pipeline_layout(
        &{label = "Render Pipeline Layout"},
    ) or_return
    defer render_pipeline_layout->release()

    vertex_buffer_layout := wgpu.Vertex_Buffer_Layout {
        array_stride = size_of(Vertex),
        step_mode = .Vertex,
        attributes = {
            {offset = 0, shader_location = 0, format = .Float32x3},
            {
                offset = cast(u64)offset_of(Vertex, color),
                shader_location = 1,
                format = .Float32x3,
            },
        },
    }

    render_pipeline_descriptor := wgpu.Render_Pipeline_Descriptor {
        label = "Render Pipeline",
        layout = &render_pipeline_layout,
        vertex = {
            module = &shader,
            entry_point = "vs_main",
            buffers = {vertex_buffer_layout},
        },
        fragment = &{
            module = &shader,
            entry_point = "fs_main",
            targets = {
                {
                    format = state.config.format,
                    blend = &wgpu.Blend_State_Replace,
                    write_mask = wgpu.Color_Write_Mask_All,
                },
            },
        },
        primitive = {topology = .Triangle_List, front_face = .CCW, cull_mode = .None},
        depth_stencil = nil,
        multisample = {count = 1, mask = ~u32(0), alpha_to_coverage_enabled = false},
    }

    state.render_pipeline = state.device->create_render_pipeline(
        &render_pipeline_descriptor,
    ) or_return

    // vertices := []Vertex{
    //     {position = {0.0, 0.5, 0.0}, color = {1.0, 0.0, 0.0}},
    //     {position = {-0.5, -0.5, 0.0}, color = {0.0, 1.0, 0.0}},
    //     {position = {0.5, -0.5, 0.0}, color = {0.0, 0.0, 1.0}},
    // }

    vertices := []Vertex {
        {position = {-0.0868241, 0.49240386, 0.0}, color = {0.5, 0.0, 0.5}}, // A
        {position = {-0.49513406, 0.06958647, 0.0}, color = {0.5, 0.0, 0.5}}, // B
        {position = {-0.21918549, -0.44939706, 0.0}, color = {0.5, 0.0, 0.5}}, // C
        {position = {0.35966998, -0.3473291, 0.0}, color = {0.5, 0.0, 0.5}}, // D
        {position = {0.44147372, 0.2347359, 0.0}, color = {0.5, 0.0, 0.5}}, // E
    }

    indices: []u16 = {0, 1, 4, 1, 2, 4, 2, 3, 4}

    // state.num_vertices = cast(u32)len(vertices)
    state.num_indices = cast(u32)len(indices)

    state.vertex_buffer = state.device->create_buffer_with_data(
        &wgpu.Buffer_Data_Descriptor{
            label = "Vertex Buffer",
            contents = wgpu.to_bytes(vertices),
            usage = {.Vertex},
        },
    ) or_return

    state.index_buffer = state.device->create_buffer_with_data(
        &wgpu.Buffer_Data_Descriptor{
            label = "Index Buffer",
            contents = wgpu.to_bytes(indices),
            usage = {.Index},
        },
    ) or_return

    num_vertices :: 100
    angle := math.PI * 2.0 / f32(num_vertices)
    challenge_verts: [num_vertices]Vertex

    for i := 0; i < num_vertices; i += 1 {
        theta := angle * f32(i)
        theta_sin, theta_cos := math.sincos_f64(f64(theta))

        challenge_verts[i] = Vertex {
            position = {0.5 * f32(theta_cos), -0.5 * f32(theta_sin), 0.0},
            color = {(1.0 + f32(theta_cos)) / 2.0, (1.0 + f32(theta_sin)) / 2.0, 1.0},
        }
    }

    num_triangles :: num_vertices - 2
    challenge_indices: [num_triangles * 3]u16
    {
        index := 0
        for i := u16(1); i < num_triangles + 1; i += 1 {
            challenge_indices[index] = i + 1
            challenge_indices[index + 1] = i
            challenge_indices[index + 2] = 0
            index += 3
        }
    }

    state.num_challenge_indices = len(challenge_indices)

    state.challenge_vertex_buffer = state.device->create_buffer_with_data(
        &wgpu.Buffer_Data_Descriptor{
            label = "Vertex Buffer",
            contents = wgpu.to_bytes(challenge_verts[:]),
            usage = {.Vertex},
        },
    ) or_return

    state.challenge_index_buffer = state.device->create_buffer_with_data(
        &wgpu.Buffer_Data_Descriptor{
            label = "Index Buffer",
            contents = wgpu.to_bytes(challenge_indices[:]),
            usage = {.Index},
        },
    ) or_return

    return state, .No_Error
}

resize_window :: proc(state: ^State, size: Physical_Size) -> wgpu.Error_Type {
    if size.width == 0 && size.height == 0 {
        return .No_Error
    }

    state.config.width = size.width
    state.config.height = size.height

    if state.swap_chain.ptr != nil {
        state.swap_chain->release()
    }

    state.swap_chain = state.device->create_swap_chain(
        &state.surface,
        &state.config,
    ) or_return

    return .No_Error
}

render :: proc(state: ^State) -> wgpu.Error_Type {
    next_texture := state.swap_chain->get_current_texture_view() or_return
    defer next_texture->release()

    encoder := state.device->create_command_encoder(
        &wgpu.Command_Encoder_Descriptor{label = "Command Encoder"},
    ) or_return
    defer encoder->release()

    render_pass := encoder->begin_render_pass(
        &{
            label = "Render Pass",
            color_attachments = []wgpu.Render_Pass_Color_Attachment{
                {
                    view = &next_texture,
                    resolve_target = nil,
                    load_op = .Clear,
                    store_op = .Store,
                    clear_value = {0.1, 0.2, 0.3, 1.0},
                },
            },
            depth_stencil_attachment = nil,
        },
    )
    defer render_pass->release()

    render_pass->set_pipeline(&state.render_pipeline)

    if state.use_complex {
        render_pass->set_vertex_buffer(0, state.challenge_vertex_buffer)
        render_pass->set_index_buffer(
            state.challenge_index_buffer,
            .Uint16,
            0,
            wgpu.Whole_Size,
        )
        render_pass->draw_indexed(state.num_challenge_indices)
    } else {
        render_pass->set_vertex_buffer(0, state.vertex_buffer)
        render_pass->set_index_buffer(state.index_buffer, .Uint16, 0, wgpu.Whole_Size)
        render_pass->draw_indexed(state.num_indices)
    }

    // render_pass->draw(state.num_vertices)
    render_pass->end()

    command_buffer := encoder->finish() or_return
    defer command_buffer->release()

    state.device.queue->submit(command_buffer)
    state.swap_chain->present()

    return .No_Error
}

main :: proc() {
    sdl_flags := sdl.InitFlags{.VIDEO, .JOYSTICK, .GAMECONTROLLER, .EVENTS}

    if res := sdl.Init(sdl_flags); res != 0 {
        fmt.eprintf("ERROR: Failed to initialize SDL: [%s]\n", sdl.GetError())
        return
    }
    defer sdl.Quit()

    window_flags: sdl.WindowFlags = {.SHOWN, .ALLOW_HIGHDPI, .RESIZABLE}

    sdl_window := sdl.CreateWindow(
        "Tutorial 4 - Buffer Challenge",
        sdl.WINDOWPOS_CENTERED,
        sdl.WINDOWPOS_CENTERED,
        800,
        600,
        window_flags,
    )
    defer sdl.DestroyWindow(sdl_window)

    if sdl_window == nil {
        fmt.eprintf("ERROR: Failed to create the SDL Window: [%s]\n", sdl.GetError())
        return
    }

    state, state_err := init_state(sdl_window)
    if state_err != .No_Error {
        message := wgpu.get_error_message()
        if message != "" {
            fmt.eprintln("ERROR: Failed to initilize program:", message)
        } else {
            fmt.eprintln("ERROR: Failed to initilize program")
        }
        return
    }
    defer {
        state.challenge_vertex_buffer->release()
        state.challenge_index_buffer->release()
        state.index_buffer->release()
        state.vertex_buffer->release()
        state.render_pipeline->release()
        state.swap_chain->release()
        state.device->release()
        state.surface->release()
    }

    err := wgpu.Error_Type{}

    main_loop: for {
        e: sdl.Event

        for sdl.PollEvent(&e) {
            #partial switch (e.type) {
            case .QUIT:
                break main_loop

            case .WINDOWEVENT:
                #partial switch (e.window.event) {
                case .SIZE_CHANGED:
                case .RESIZED:
                    err = resize_window(
                        &state,
                        {cast(u32)e.window.data1, cast(u32)e.window.data2},
                    )
                    if err != .No_Error do break main_loop

                case .MINIMIZED:
                    state.minimized = true

                case .RESTORED:
                    state.minimized = false
                }

            case .KEYDOWN:
                if e.key.keysym.sym == .SPACE {
                    state.use_complex = true
                }

            case .KEYUP:
                if e.key.keysym.sym == .SPACE {
                    state.use_complex = false
                }
            }
        }

        if !state.minimized {
            err = render(&state)
            if err != .No_Error do break main_loop
        }
    }

    if err != .No_Error {
        fmt.eprintf("Error occurred while rendering: %v\n", wgpu.get_error_message())
    }

    fmt.println("Exiting...")
}
