.class public interface abstract Lcom/taobao/application/common/IAppLaunchListener;
.super Ljava/lang/Object;
.source "IAppLaunchListener.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/application/common/IAppLaunchListener$LaunchStatus;
    }
.end annotation


# static fields
.field public static final COLD:I = 0x0

.field public static final HOT:I = 0x1

.field public static final LAUNCH_COMPLETED:I = 0x4

.field public static final LAUNCH_DRAW_START:I = 0x0

.field public static final LAUNCH_INTERACTIVE:I = 0x2

.field public static final LAUNCH_SKI_INTERACTIVE:I = 0x3

.field public static final LAUNCH_VISIBLE:I = 0x1


# virtual methods
.method public abstract onLaunchChanged(II)V
.end method
