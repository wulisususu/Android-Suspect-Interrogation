.class public final Landroidx/compose/material3/windowsizeclass/WindowSizeClass$Companion;
.super Ljava/lang/Object;
.source "WindowSizeClass.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/compose/material3/windowsizeclass/WindowSizeClass;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Companion"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u0086\u0003\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u001d\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006H\u0007\u00f8\u0001\u0000\u00f8\u0001\u0001\u00a2\u0006\u0004\u0008\u0007\u0010\u0008\u0082\u0002\u000b\n\u0005\u0008\u00a1\u001e0\u0001\n\u0002\u0008\u0019\u00a8\u0006\t"
    }
    d2 = {
        "Landroidx/compose/material3/windowsizeclass/WindowSizeClass$Companion;",
        "",
        "()V",
        "calculateFromSize",
        "Landroidx/compose/material3/windowsizeclass/WindowSizeClass;",
        "size",
        "Landroidx/compose/ui/unit/DpSize;",
        "calculateFromSize-EaSLcWc",
        "(J)Landroidx/compose/material3/windowsizeclass/WindowSizeClass;",
        "material3-window-size-class_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public synthetic constructor <init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0}, Landroidx/compose/material3/windowsizeclass/WindowSizeClass$Companion;-><init>()V

    return-void
.end method


# virtual methods
.method public final calculateFromSize-EaSLcWc(J)Landroidx/compose/material3/windowsizeclass/WindowSizeClass;
    .locals 2

    .line 54
    sget-object v0, Landroidx/compose/material3/windowsizeclass/WindowWidthSizeClass;->Companion:Landroidx/compose/material3/windowsizeclass/WindowWidthSizeClass$Companion;

    invoke-static {p1, p2}, Landroidx/compose/ui/unit/DpSize;->getWidth-D9Ej5fM(J)F

    move-result v1

    invoke-virtual {v0, v1}, Landroidx/compose/material3/windowsizeclass/WindowWidthSizeClass$Companion;->fromWidth-rEPKUCk$material3_window_size_class_release(F)I

    move-result v0

    .line 55
    sget-object v1, Landroidx/compose/material3/windowsizeclass/WindowHeightSizeClass;->Companion:Landroidx/compose/material3/windowsizeclass/WindowHeightSizeClass$Companion;

    invoke-static {p1, p2}, Landroidx/compose/ui/unit/DpSize;->getHeight-D9Ej5fM(J)F

    move-result p1

    invoke-virtual {v1, p1}, Landroidx/compose/material3/windowsizeclass/WindowHeightSizeClass$Companion;->fromHeight-At195nw$material3_window_size_class_release(F)I

    move-result p1

    .line 56
    new-instance p2, Landroidx/compose/material3/windowsizeclass/WindowSizeClass;

    const/4 v1, 0x0

    invoke-direct {p2, v0, p1, v1}, Landroidx/compose/material3/windowsizeclass/WindowSizeClass;-><init>(IILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-object p2
.end method
