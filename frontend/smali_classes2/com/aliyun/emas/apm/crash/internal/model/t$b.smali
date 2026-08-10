.class final Lcom/aliyun/emas/apm/crash/internal/model/t$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/t;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/lang/Double;

.field private b:I

.field private c:Z

.field private d:I

.field private e:J

.field private f:J

.field private g:B


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;
    .locals 12

    iget-byte v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    const/16 v1, 0x1f

    if-eq v0, v1, :cond_5

    .line 2
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    and-int/lit8 v1, v1, 0x1

    if-nez v1, :cond_0

    const-string v1, " batteryVelocity"

    .line 4
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    and-int/lit8 v1, v1, 0x2

    if-nez v1, :cond_1

    const-string v1, " proximityOn"

    .line 7
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    and-int/lit8 v1, v1, 0x4

    if-nez v1, :cond_2

    const-string v1, " orientation"

    .line 10
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    and-int/lit8 v1, v1, 0x8

    if-nez v1, :cond_3

    const-string v1, " ramUsed"

    .line 13
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-byte v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    and-int/lit8 v1, v1, 0x10

    if-nez v1, :cond_4

    const-string v1, " diskUsed"

    .line 16
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 18
    :cond_4
    new-instance v1, Ljava/lang/IllegalStateException;

    new-instance v2, Ljava/lang/StringBuilder;

    const-string v3, "Missing required properties:"

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v1, v0}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 20
    :cond_5
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/t;

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->a:Ljava/lang/Double;

    iget v4, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->b:I

    iget-boolean v5, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->c:Z

    iget v6, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->d:I

    iget-wide v7, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->e:J

    iget-wide v9, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->f:J

    const/4 v11, 0x0

    move-object v2, v0

    invoke-direct/range {v2 .. v11}, Lcom/aliyun/emas/apm/crash/internal/model/t;-><init>(Ljava/lang/Double;IZIJJLcom/aliyun/emas/apm/crash/internal/model/t$a;)V

    return-object v0
.end method

.method public setBatteryLevel(Ljava/lang/Double;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->a:Ljava/lang/Double;

    return-object p0
.end method

.method public setBatteryVelocity(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->b:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    or-int/lit8 p1, p1, 0x1

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    return-object p0
.end method

.method public setDiskUsed(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->f:J

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    or-int/lit8 p1, p1, 0x10

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    return-object p0
.end method

.method public setOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->d:I

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    or-int/lit8 p1, p1, 0x4

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    return-object p0
.end method

.method public setProximityOn(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->c:Z

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    or-int/lit8 p1, p1, 0x2

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    return-object p0
.end method

.method public setRamUsed(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->e:J

    iget-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    or-int/lit8 p1, p1, 0x8

    int-to-byte p1, p1

    iput-byte p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/t$b;->g:B

    return-object p0
.end method
