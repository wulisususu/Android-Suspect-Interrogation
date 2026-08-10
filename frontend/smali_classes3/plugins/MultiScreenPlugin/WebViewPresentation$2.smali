.class Lplugins/MultiScreenPlugin/WebViewPresentation$2;
.super Ljava/lang/Object;
.source "WebViewPresentation.java"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lplugins/MultiScreenPlugin/WebViewPresentation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;


# direct methods
.method constructor <init>(Lplugins/MultiScreenPlugin/WebViewPresentation;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 65
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0

    .line 68
    check-cast p2, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 69
    invoke-virtual {p2}, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;->getService()Lplugins/MultiScreenPlugin/ScreenCaptureService;

    move-result-object p2

    invoke-static {p1, p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fputscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewPresentation;Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    const/4 p2, 0x1

    .line 70
    invoke-static {p1, p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fputisServiceBound(Lplugins/MultiScreenPlugin/WebViewPresentation;Z)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 73
    invoke-static {p1}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/webkit/WebView;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 74
    invoke-static {p1}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewPresentation;)Lplugins/MultiScreenPlugin/ScreenCaptureService;

    move-result-object p1

    iget-object p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    invoke-static {p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/webkit/WebView;

    move-result-object p2

    invoke-virtual {p1, p2}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->setTargetWebView(Landroid/webkit/WebView;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 75
    invoke-static {p1}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewPresentation;)Lplugins/MultiScreenPlugin/ScreenCaptureService;

    move-result-object p1

    iget-object p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    invoke-virtual {p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;->getWindow()Landroid/view/Window;

    move-result-object p2

    invoke-virtual {p1, p2}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->setWindow(Landroid/view/Window;)V

    const-string p1, "WebViewPresentation"

    const-string p2, "\u622a\u56fe\u670d\u52a1\u5df2\u8fde\u63a5\u5e76\u8bbe\u7f6eWebView (Presentation\u6a21\u5f0f)"

    .line 76
    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    const/4 v0, 0x0

    .line 82
    invoke-static {p1, v0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fputisServiceBound(Lplugins/MultiScreenPlugin/WebViewPresentation;Z)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$2;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    const/4 v0, 0x0

    .line 83
    invoke-static {p1, v0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fputscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewPresentation;Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    const-string p1, "WebViewPresentation"

    const-string v0, "\u622a\u56fe\u670d\u52a1\u8fde\u63a5\u65ad\u5f00"

    .line 84
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
