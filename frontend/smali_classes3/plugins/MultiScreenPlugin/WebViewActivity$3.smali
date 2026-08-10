.class Lplugins/MultiScreenPlugin/WebViewActivity$3;
.super Landroid/webkit/WebChromeClient;
.source "WebViewActivity.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lplugins/MultiScreenPlugin/WebViewActivity;->onCreate(Landroid/os/Bundle;)V
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

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewActivity$3;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 101
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    return-void
.end method

.method static synthetic lambda$onPermissionRequest$0(Landroid/webkit/PermissionRequest;)V
    .locals 1

    .line 105
    invoke-virtual {p0}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    .locals 2

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity$3;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 104
    invoke-static {v0, p1}, Lplugins/MultiScreenPlugin/WebViewActivity;->-$$Nest$fputcurrentPermissionRequest(Lplugins/MultiScreenPlugin/WebViewActivity;Landroid/webkit/PermissionRequest;)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewActivity$3;->this$0:Lplugins/MultiScreenPlugin/WebViewActivity;

    .line 105
    new-instance v1, Lplugins/MultiScreenPlugin/WebViewActivity$3$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lplugins/MultiScreenPlugin/WebViewActivity$3$$ExternalSyntheticLambda0;-><init>(Landroid/webkit/PermissionRequest;)V

    invoke-virtual {v0, v1}, Lplugins/MultiScreenPlugin/WebViewActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
