.class Lplugins/MultiScreenPlugin/WebViewActivity$2;
.super Ljava/lang/Object;
.source "WebViewActivity.java"

# interfaces
.implements Landroid/content/ServiceConnection;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lplugins/MultiScreenPlugin/WebViewActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/MultiScreenPlugin/WebViewActivity;


# direct methods
.method constructor <init>(Lplugins/MultiScreenPlugin/WebViewActivity;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 60
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onServiceConnected(Landroid/content/ComponentName;Landroid/os/IBinder;)V
    .locals 0

    .line 63
    check-cast p2, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 64
    invoke-virtual {p2}, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;->getService()Lplugins/MultiScreenPlugin/ScreenCaptureService;

    move-result-object p2

    invoke-static {p1, p2}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fputscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewActivity;Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    const/4 p2, 0x1

    .line 65
    invoke-static {p1, p2}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fputisServiceBound(Lplugins/MultiScreenPlugin/WebViewActivity;Z)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 68
    invoke-static {p1}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewActivity;)Landroid/webkit/WebView;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 69
    invoke-static {p1}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fgetscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewActivity;)Lplugins/MultiScreenPlugin/ScreenCaptureService;

    move-result-object p1

    iget-object p2, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    invoke-static {p2}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewActivity;)Landroid/webkit/WebView;

    move-result-object p2

    invoke-virtual {p1, p2}, Lplugins/MultiScreenPlugin/ScreenCaptureService;->setTargetWebView(Landroid/webkit/WebView;)V

    const-string p1, "WebViewActivity"

    const-string p2, "\u622a\u56fe\u670d\u52a1\u5df2\u8fde\u63a5\u5e76\u8bbe\u7f6eWebView"

    .line 70
    invoke-static {p1, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    :cond_0
    return-void
.end method

.method public onServiceDisconnected(Landroid/content/ComponentName;)V
    .locals 1

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    const/4 v0, 0x0

    .line 76
    invoke-static {p1, v0}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fputisServiceBound(Lplugins/MultiScreenPlugin/WebViewActivity;Z)V

    iget-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$2;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    const/4 v0, 0x0

    .line 77
    invoke-static {p1, v0}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fputscreenCaptureService(Lplugins/MultiScreenPlugin/WebViewActivity;Lplugins/MultiScreenPlugin/ScreenCaptureService;)V

    const-string p1, "WebViewActivity"

    const-string v0, "\u622a\u56fe\u670d\u52a1\u8fde\u63a5\u65ad\u5f00"

    .line 78
    invoke-static {p1, v0}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    return-void
.end method
