.class public final synthetic Lplugins/MultiScreenPlugin/WebViewPresentation$3$$ExternalSyntheticLambda0;
.super Ljava/lang/Object;
.source "D8$$SyntheticClass"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field public final synthetic f$0:Landroid/webkit/PermissionRequest;


# direct methods
.method public synthetic constructor <init>(Landroid/webkit/PermissionRequest;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$3$$ExternalSyntheticLambda0;->f$0:Landroid/webkit/PermissionRequest;

    return-void
.end method


# virtual methods
.method public final run()V
    .locals 1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/WebViewPresentation$3$$ExternalSyntheticLambda0;->f$0:Landroid/webkit/PermissionRequest;

    invoke-static {v0}, Lplugins/MultiScreenPlugin/WebViewPresentation$3;->lambda$onPermissionRequest$0(Landroid/webkit/PermissionRequest;)V

    return-void
.end method
