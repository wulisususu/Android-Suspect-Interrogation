.class public interface abstract Lcom/taobao/application/common/IApmEventListener;
.super Ljava/lang/Object;
.source "IApmEventListener.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/application/common/IApmEventListener$ApmEventType;
    }
.end annotation


# static fields
.field public static final NOTIFY_BACKGROUND_2_FOREGROUND:I = 0x2

.field public static final NOTIFY_FOREGROUND_2_BACKGROUND:I = 0x1

.field public static final NOTIFY_FOR_IN_BACKGROUND:I = 0x32


# virtual methods
.method public abstract onEvent(I)V
.end method
