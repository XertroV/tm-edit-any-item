#if MP4

// mp4 will never be updated so just nop the calls dw about patterns
const string CanEditBlockItemCall1 = "e8 77 df ff ff 85 c0 0f 84 6b 05 00 00 48 8d 8e c0 0f 00 00 e8 f3 d1 e2 ff 89 be c0 0f 00 00";
const string CanEditBlockItemCall2 = "e8 25 df ff ff 85 c0 0f 84 19 05 00 00 89 be c0 0f 00 00 48 8b 9e 80 05 00 00 48 8b 8e 10 10 00 00";

MemPatcher@ PatchCall1 = MemPatcher(
    CanEditBlockItemCall1, {0}, {"90 90 90 90 90"}
);
MemPatcher@ PatchCall2 = MemPatcher(
    CanEditBlockItemCall2, {0}, {"90 90 90 90 90"}
);

#elif TURBO

// in turbo there is only one call to this function. I guess no one will ever run this on turbo tho b/c there isn't really custom item support
const string CanEditItemCall1 = "e8 15 96 d3 ff 85 c0 74 17 83 b8 94 00 00 00 01 74 0e 6a 05 8b cb e8 cf 9a eb ff e9 2f 0b 00 00";
MemPatcher@ PatchCall1 = MemPatcher(
    CanEditItemCall1, {0}, {"90 90 90 90 90"}
);

#elif TMNEXT
//                                       vv function offset      vv jump offset       vv editor offset  vv call           vv editor offset     vv editor offset
const string CanEditBlockItemCall1 = "e8 ?? ?? ?? ?? 85 c0 0f 84 ?? ?? 00 00 48 8d 8f ?? ?? 00 00 e8 ?? ?? ?? ?? 48 8b 87 ?? ?? 00 00 48 89 87 ?? ?? 00 00";
const string CanEditBlockItemCall2 = "e8 ?? ?? ?? ?? 85 c0 0f 84 ?? ?? 00 00 48 8b 9f ?? ?? 00 00 44 89 bf ?? ?? 00 00 48 8b 8f ?? ?? 00 00 48 3b d9";
//                                                                                                         ^^ editor offset     ^^ editor offset
MemPatcher@ PatchCall1 = MemPatcher(
    CanEditBlockItemCall1, {0}, {"90 90 90 90 90"}
);
MemPatcher@ PatchCall2 = MemPatcher(
    CanEditBlockItemCall2, {0}, {"90 90 90 90 90"}
);

#endif

#if TMNEXT || MP4

bool IsPatchEnabled {
    get {
        return PatchCall1.IsApplied && PatchCall2.IsApplied;
    }
    set {
        PatchCall1.IsApplied = value;
        PatchCall2.IsApplied = value;
    }
}

#elif TURBO

bool IsPatchEnabled {
    get {
        return PatchCall1.IsApplied;
    }
    set {
        PatchCall1.IsApplied = value;
    }
}

#endif
