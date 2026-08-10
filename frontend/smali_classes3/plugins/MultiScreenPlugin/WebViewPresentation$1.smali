.class Lplugins/MultiScreenPlugin/WebViewPresentation$1;
.super Landroid/content/BroadcastReceiver;
.source "WebViewPresentation.java"


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

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$1;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 48
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 1

    const-string p1, "multi_screen.main_screen_message"

    .line 51
    invoke-virtual {p2}, Landroid/content/Intent;->getAction()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1, v0}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_0

    return-void

    :cond_0
    const-string p1, "message"

    .line 54
    invoke-virtual {p2, p1}, Landroid/content/Intent;->getStringExtra(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 55
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "\u6536\u5230\u5e7f\u64ad: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p2

    const-string v0, "BroadcastReceiver"

    invoke-static {v0, p2}, Landroid/util/Log;->d(Ljava/lang/String;Ljava/lang/String;)I

    .line 56
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "window.postMessage("

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    const-string p2, ", \'*\');"

    invoke-virtual {p1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    iget-object p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$1;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 58
    invoke-static {p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/webkit/WebView;

    move-result-object p2

    if-eqz p2, :cond_1

    iget-object p2, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$1;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 59
    invoke-static {p2}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetwebView(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/webkit/WebView;

    move-result-object p2

    const/4 v0, 0x0

    invoke-virtual {p2, p1, v0}, Landroid/webkit/WebView;->evaluateJavascript(Ljava/lang/String;Landroid/webkit/ValueCallback;)V

    :cond_1
    return-void
.end method
