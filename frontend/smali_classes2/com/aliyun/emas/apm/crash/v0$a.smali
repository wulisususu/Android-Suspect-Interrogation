.class public Lcom/aliyun/emas/apm/crash/v0$a;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/v0;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field public final a:Z

.field public final b:Z

.field public final c:Z


# direct methods
.method public constructor <init>(ZZZ)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/v0$a;->a:Z

    iput-boolean p2, p0, Lcom/aliyun/emas/apm/crash/v0$a;->b:Z

    iput-boolean p3, p0, Lcom/aliyun/emas/apm/crash/v0$a;->c:Z

    return-void
.end method
