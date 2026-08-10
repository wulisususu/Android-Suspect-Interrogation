.class public interface abstract Lcom/taobao/application/common/IPageListener;
.super Ljava/lang/Object;
.source "IPageListener.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/application/common/IPageListener$PageStatus;
    }
.end annotation


# static fields
.field public static final DRAW_START:I = 0x1

.field public static final INIT_TIME:I = 0x0

.field public static final INTERACTIVE:I = 0x3

.field public static final SKI_INTERACTIVE:I = 0x4

.field public static final VISIBLE:I = 0x2


# virtual methods
.method public abstract onPageChanged(Ljava/lang/String;IJ)V
.end method
