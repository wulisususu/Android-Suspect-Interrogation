.class abstract Lcom/aliyun/emas/apm/crash/w;
.super Ljava/lang/Object;
.source "SourceFile"


# direct methods
.method static a(Lcom/aliyun/emas/apm/crash/t;)Lcom/aliyun/emas/apm/crash/v0;
    .locals 12

    .line 1
    new-instance v3, Lcom/aliyun/emas/apm/crash/v0$b;

    const/16 v0, 0x8

    const/4 v1, 0x4

    invoke-direct {v3, v0, v1}, Lcom/aliyun/emas/apm/crash/v0$b;-><init>(II)V

    .line 5
    new-instance v4, Lcom/aliyun/emas/apm/crash/v0$a;

    const/4 v0, 0x1

    invoke-direct {v4, v0, v0, v0}, Lcom/aliyun/emas/apm/crash/v0$a;-><init>(ZZZ)V

    .line 12
    invoke-interface {p0}, Lcom/aliyun/emas/apm/crash/t;->a()J

    move-result-wide v0

    const p0, 0x36ee80

    int-to-long v5, p0

    add-long v1, v0, v5

    .line 14
    new-instance p0, Lcom/aliyun/emas/apm/crash/v0;

    const/4 v5, 0x0

    const/16 v6, 0xe10

    const-wide/high16 v7, 0x4024000000000000L    # 10.0

    const-wide v9, 0x3ff3333333333333L    # 1.2

    const/16 v11, 0x3c

    move-object v0, p0

    invoke-direct/range {v0 .. v11}, Lcom/aliyun/emas/apm/crash/v0;-><init>(JLcom/aliyun/emas/apm/crash/v0$b;Lcom/aliyun/emas/apm/crash/v0$a;IIDDI)V

    return-object p0
.end method
