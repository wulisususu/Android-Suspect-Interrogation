.class public abstract Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;
.super Ljava/lang/Object;
.source "ZoomGestureDetector.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Landroidx/camera/view/impl/ZoomGestureDetector;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "ZoomEvent"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent$Begin;,
        Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent$End;,
        Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent$Move;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u000b\u0008&\u0018\u00002\u00020\u0001:\u0003\r\u000e\u000fB%\u0008\u0002\u0012\u0008\u0008\u0001\u0010\u0002\u001a\u00020\u0003\u0012\u0008\u0008\u0001\u0010\u0004\u001a\u00020\u0005\u0012\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0007R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0008\u0010\tR\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\n\u0010\u000bR\u0011\u0010\u0006\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000c\u0010\u000b\u00a8\u0006\u0010"
    }
    d2 = {
        "Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;",
        "",
        "eventTime",
        "",
        "focusX",
        "",
        "focusY",
        "(JII)V",
        "getEventTime",
        "()J",
        "getFocusX",
        "()I",
        "getFocusY",
        "Begin",
        "End",
        "Move",
        "camera-view_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final eventTime:J

.field private final focusX:I

.field private final focusY:I


# direct methods
.method private constructor <init>(JII)V
    .locals 0

    .line 73
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;->eventTime:J

    iput p3, p0, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;->focusX:I

    iput p4, p0, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;->focusY:I

    return-void
.end method

.method public synthetic constructor <init>(JIILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 0

    invoke-direct {p0, p1, p2, p3, p4}, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;-><init>(JII)V

    return-void
.end method


# virtual methods
.method public final getEventTime()J
    .locals 2

    iget-wide v0, p0, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;->eventTime:J

    return-wide v0
.end method

.method public final getFocusX()I
    .locals 1

    iget v0, p0, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;->focusX:I

    return v0
.end method

.method public final getFocusY()I
    .locals 1

    iget v0, p0, Landroidx/camera/view/impl/ZoomGestureDetector$ZoomEvent;->focusY:I

    return v0
.end method
