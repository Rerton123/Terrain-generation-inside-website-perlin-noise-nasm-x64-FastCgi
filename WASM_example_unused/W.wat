(module
  (func $answer (result i32)
    i32.const 4211
    i32.const 2
    i32.div_s
  )

  (export "answer" (func $answer))
)