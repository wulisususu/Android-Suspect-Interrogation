.class Lorg/android/spdy/SpdySession$1;
.super Ljava/lang/Object;
.source "SpdySession.java"

# interfaces
.implements Lorg/android/spdy/ProtectedPointer$ProtectedPointerOnClose;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lorg/android/spdy/SpdySession;-><init>(JLorg/android/spdy/SpdyAgent;Ljava/lang/String;Ljava/lang/String;Lorg/android/spdy/SessionCb;IILjava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lorg/android/spdy/SpdySession;


# direct methods
.method constructor <init>(Lorg/android/spdy/SpdySession;)V
    .locals 0

    iput-object p1, p0, Lorg/android/spdy/SpdySession$1;->this$0:Lorg/android/spdy/SpdySession;

    .line 50
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public close(Ljava/lang/Object;)V
    .locals 2

    .line 53
    check-cast p1, Lorg/android/spdy/SpdySession;

    .line 54
    invoke-static {p1}, Lorg/android/spdy/SpdySession;->access$000(Lorg/android/spdy/SpdySession;)J

    move-result-wide v0

    invoke-static {p1, v0, v1}, Lorg/android/spdy/SpdySession;->access$100(Lorg/android/spdy/SpdySession;J)I

    const-wide/16 v0, 0x0

    .line 55
    invoke-virtual {p1, v0, v1}, Lorg/android/spdy/SpdySession;->setSessionNativePtr(J)V

    return-void
.end method
