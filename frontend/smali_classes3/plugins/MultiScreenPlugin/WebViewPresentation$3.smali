.class Lplugins/MultiScreenPlugin/WebViewPresentation$3;
.super Landroid/webkit/WebChromeClient;
.source "WebViewPresentation.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lplugins/MultiScreenPlugin/WebViewPresentation;->onCreate(Landroid/os/Bundle;)V
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

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$3;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 111
    invoke-direct {p0}, Landroid/webkit/WebChromeClient;-><init>()V

    return-void
.end method

.method static synthetic lambda$onPermissionRequest$0(Landroid/webkit/PermissionRequest;)V
    .locals 1

    .line 117
    invoke-virtual {p0}, Landroid/webkit/PermissionRequest;->getResources()[Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0, v0}, Landroid/webkit/PermissionRequest;->grant([Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public onPermissionRequest(Landroid/webkit/PermissionRequest;)V
    .locals 2

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$3;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 114
    invoke-static {v0, p1}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fputcurrentPermissionRequest(Lplugins/MultiScreenPlugin/WebViewPresentation;Landroid/webkit/PermissionRequest;)V

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$3;->this$0:Lplugins/MultiScreenPlugin/WebViewPresentation;

    .line 116
    invoke-static {v0}, Lplugins/MultiScreenPlugin/WebViewPresentation;->-$$Nest$fgetactivity(Lplugins/MultiScreenPlugin/WebViewPresentation;)Landroid/app/Activity;

    move-result-object v0

    new-instance v1, Lplugins/MultiScreenPlugin/WebViewPresentation$3$$ExternalSyntheticLambda0;

    invoke-direct {v1, p1}, Lplugins/MultiScreenPlugin/WebViewPresentation$3$$ExternalSyntheticLambda0;-><init>(Landroid/webkit/PermissionRequest;)V

    invoke-virtual {v0, v1}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
