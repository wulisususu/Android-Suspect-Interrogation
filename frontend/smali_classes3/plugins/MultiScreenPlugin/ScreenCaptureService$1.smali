.class Lplugins/MultiScreenPlugin/ScreenCaptureService$1;
.super Ljava/lang/Object;
.source "ScreenCaptureService.java"

# interfaces
.implements Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lplugins/MultiScreenPlugin/ScreenCaptureService;->startCaptureThread()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;


# direct methods
.method public static synthetic $r8$lambda$ffeB-AQQcKASISCcM7yFn9i-qK8(Lplugins/MultiScreenPlugin/ScreenCaptureService$1;[B)V
    .locals 0

    invoke-direct {p0, p1}, Lplugins/MultiScreenPlugin/ScreenCaptureService$1;->lambda$onSuccess$0([B)V

    return-void
.end method

.method constructor <init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$1;->this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    .line 223
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private synthetic lambda$onSuccess$0([B)V
    .locals 1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$1;->this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    .line 227
    invoke-static {v0, p1}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->-$$Nest$mbroadcastFrame(Lplugins/MultiScreenPlugin/ScreenCaptureService;[B)V

    return-void
.end method


# virtual methods
.method public onError(Ljava/lang/String;)V
    .locals 2

    .line 232
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "\u622a\u56fe\u5931\u8d25: "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    const-string v0, "ScreenCaptureService"

    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method

.method public onSuccess([B)V
    .locals 2

    if-eqz p1, :cond_0

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$1;->this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    .line 227
    invoke-static {v0}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->-$$Nest$fgetbroadcastExecutor(Lplugins/MultiScreenPlugin/ScreenCaptureService;)Ljava/util/concurrent/ExecutorService;

    move-result-object v0

    new-instance v1, Lplugins/MultiScreenPlugin/ScreenCaptureService$1$$ExternalSyntheticLambda0;

    invoke-direct {v1, p0, p1}, Lplugins/MultiScreenPlugin/ScreenCaptureService$1$$ExternalSyntheticLambda0;-><init>(Lplugins/MultiScreenPlugin/ScreenCaptureService$1;[B)V

    invoke-interface {v0, v1}, Ljava/util/concurrent/ExecutorService;->execute(Ljava/lang/Runnable;)V

    :cond_0
    return-void
.end method
