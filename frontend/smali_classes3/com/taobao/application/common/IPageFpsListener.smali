.class public interface abstract Lcom/taobao/application/common/IPageFpsListener;
.super Ljava/lang/Object;
.source "IPageFpsListener.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/application/common/IPageFpsListener$FpsType;
    }
.end annotation


# static fields
.field public static final LOAD_FPS:I = 0x0

.field public static final USE_FPS:I = 0x1


# virtual methods
.method public abstract onPageFpsReceived(Ljava/lang/String;Ljava/lang/Object;IF)V
.end method
