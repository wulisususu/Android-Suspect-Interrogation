.class public abstract Lcom/taobao/agoo/TaobaoBaseIntentService;
.super Lorg/android/agoo/control/BaseIntentService;
.source "Taobao"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Lorg/android/agoo/control/BaseIntentService;-><init>()V

    return-void
.end method


# virtual methods
.method protected abstract onError(Landroid/content/Context;Ljava/lang/String;)V
.end method

.method protected abstract onMessage(Landroid/content/Context;Landroid/content/Intent;)V
.end method

.method protected abstract onRegistered(Landroid/content/Context;Ljava/lang/String;)V
.end method

.method protected abstract onUnregistered(Landroid/content/Context;Ljava/lang/String;)V
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation
.end method
