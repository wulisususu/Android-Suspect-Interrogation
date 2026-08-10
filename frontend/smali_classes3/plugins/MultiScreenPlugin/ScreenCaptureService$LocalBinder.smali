.class public Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;
.super Landroid/os/Binder;
.source "ScreenCaptureService.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lplugins/MultiScreenPlugin/ScreenCaptureService;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "LocalBinder"
.end annotation


# instance fields
.field final synthetic this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;


# direct methods
.method public constructor <init>(Lplugins/MultiScreenPlugin/ScreenCaptureService;)V
    .locals 0

    iput-object p1, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;->this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    .line 44
    invoke-direct {p0}, Landroid/os/Binder;-><init>()V

    return-void
.end method


# virtual methods
.method getService()Lplugins/MultiScreenPlugin/ScreenCaptureService;
    .locals 1

    iget-object v0, p0, Lplugins/MultiScreenPlugin/ScreenCaptureService$LocalBinder;->this$0:Lplugins/MultiScreenPlugin/ScreenCaptureService;

    return-object v0
.end method
