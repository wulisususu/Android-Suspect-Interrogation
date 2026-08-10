.class public Lcom/aliyun/emas/apm/crash/v0;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/v0$b;,
        Lcom/aliyun/emas/apm/crash/v0$a;
    }
.end annotation


# instance fields
.field public final a:Lcom/aliyun/emas/apm/crash/v0$b;

.field public final b:Lcom/aliyun/emas/apm/crash/v0$a;

.field public final c:J

.field public final d:I

.field public final e:I

.field public final f:D

.field public final g:D

.field public final h:I


# direct methods
.method public constructor <init>(JLcom/aliyun/emas/apm/crash/v0$b;Lcom/aliyun/emas/apm/crash/v0$a;IIDDI)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/v0;->c:J

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/v0;->a:Lcom/aliyun/emas/apm/crash/v0$b;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/v0;->b:Lcom/aliyun/emas/apm/crash/v0$a;

    iput p5, p0, Lcom/aliyun/emas/apm/crash/v0;->d:I

    iput p6, p0, Lcom/aliyun/emas/apm/crash/v0;->e:I

    iput-wide p7, p0, Lcom/aliyun/emas/apm/crash/v0;->f:D

    iput-wide p9, p0, Lcom/aliyun/emas/apm/crash/v0;->g:D

    iput p11, p0, Lcom/aliyun/emas/apm/crash/v0;->h:I

    return-void
.end method
