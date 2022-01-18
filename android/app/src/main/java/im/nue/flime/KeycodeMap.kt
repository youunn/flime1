package im.nue.flime

import android.view.KeyEvent

class KeycodeMap {
    companion object {
        operator fun get(key: String): Int? = map[key]

        @Suppress("KotlinConstantConditions")
        fun getMetaState(modifier: Int): Int {
            var metaState = 0
            if (modifier and control > 0) {
                metaState = metaState or KeyEvent.META_CTRL_ON or KeyEvent.META_CTRL_LEFT_ON
            }
            if (modifier and shift > 0) {
                metaState = metaState or KeyEvent.META_SHIFT_ON or KeyEvent.META_SHIFT_LEFT_ON
            }
            if (modifier and alt > 0) {
                metaState = metaState or KeyEvent.META_ALT_ON or KeyEvent.META_ALT_LEFT_ON
            }
            return metaState
        }

        private const val control = 1 shl 0
        private const val shift = 1 shl 1
        private const val alt = 1 shl 2

        private val map: Map<String, Int> = mapOf(
            "Enter" to KeyEvent.KEYCODE_ENTER,
            "Backspace" to KeyEvent.KEYCODE_DEL,
            "Arrow Right" to KeyEvent.KEYCODE_DPAD_RIGHT,
            "Arrow Left" to KeyEvent.KEYCODE_DPAD_LEFT,
            "Arrow Down" to KeyEvent.KEYCODE_DPAD_DOWN,
            "Arrow Up" to KeyEvent.KEYCODE_DPAD_UP,

            "0" to KeyEvent.KEYCODE_0,
            "1" to KeyEvent.KEYCODE_1,
            "2" to KeyEvent.KEYCODE_2,
            "3" to KeyEvent.KEYCODE_3,
            "4" to KeyEvent.KEYCODE_4,
            "5" to KeyEvent.KEYCODE_5,
            "6" to KeyEvent.KEYCODE_6,
            "7" to KeyEvent.KEYCODE_7,
            "8" to KeyEvent.KEYCODE_8,
            "9" to KeyEvent.KEYCODE_9,

            "A" to KeyEvent.KEYCODE_A,
            "B" to KeyEvent.KEYCODE_B,
            "C" to KeyEvent.KEYCODE_C,
            "D" to KeyEvent.KEYCODE_D,
            "E" to KeyEvent.KEYCODE_E,
            "F" to KeyEvent.KEYCODE_F,
            "G" to KeyEvent.KEYCODE_G,
            "H" to KeyEvent.KEYCODE_H,
            "I" to KeyEvent.KEYCODE_I,
            "J" to KeyEvent.KEYCODE_J,
            "K" to KeyEvent.KEYCODE_K,
            "L" to KeyEvent.KEYCODE_L,
            "M" to KeyEvent.KEYCODE_M,
            "N" to KeyEvent.KEYCODE_N,
            "O" to KeyEvent.KEYCODE_O,
            "P" to KeyEvent.KEYCODE_P,
            "Q" to KeyEvent.KEYCODE_Q,
            "R" to KeyEvent.KEYCODE_R,
            "S" to KeyEvent.KEYCODE_S,
            "T" to KeyEvent.KEYCODE_T,
            "U" to KeyEvent.KEYCODE_U,
            "V" to KeyEvent.KEYCODE_V,
            "W" to KeyEvent.KEYCODE_W,
            "X" to KeyEvent.KEYCODE_X,
            "Y" to KeyEvent.KEYCODE_Y,
            "Z" to KeyEvent.KEYCODE_Z,

            // TODO: 用得着再补
        )
    }
}