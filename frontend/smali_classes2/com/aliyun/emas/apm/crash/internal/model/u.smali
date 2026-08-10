.class final Lcom/aliyun/emas/apm/crash/internal/model/u;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/u$b;
    }
.end annotation


# instance fields
.field private final a:I

.field private final b:I

.field private final c:I

.field private final d:I

.field private final e:I

.field private final f:I

.field private final g:I

.field private final h:I

.field private final i:I

.field private final j:Ljava/lang/String;

.field private final k:I

.field private final l:I

.field private final m:I

.field private final n:I

.field private final o:I

.field private final p:I


# direct methods
.method private constructor <init>(IIIIIIIIILjava/lang/String;IIIIII)V
    .locals 2

    move-object v0, p0

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;-><init>()V

    move v1, p1

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->a:I

    move v1, p2

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->b:I

    move v1, p3

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->c:I

    move v1, p4

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->d:I

    move v1, p5

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->e:I

    move v1, p6

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->f:I

    move v1, p7

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->g:I

    move v1, p8

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->h:I

    move v1, p9

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->i:I

    move-object v1, p10

    iput-object v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->j:Ljava/lang/String;

    move v1, p11

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->k:I

    move v1, p12

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->l:I

    move v1, p13

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->m:I

    move/from16 v1, p14

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->n:I

    move/from16 v1, p15

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->o:I

    move/from16 v1, p16

    iput v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u;->p:I

    return-void
.end method

.method synthetic constructor <init>(IIIIIIIIILjava/lang/String;IIIIIILcom/aliyun/emas/apm/crash/internal/model/u$a;)V
    .locals 0

    .line 1
    invoke-direct/range {p0 .. p16}, Lcom/aliyun/emas/apm/crash/internal/model/u;-><init>(IIIIIIIIILjava/lang/String;IIIIII)V

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p1, p0, :cond_0

    return v0

    .line 1
    :cond_0
    instance-of v1, p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    const/4 v2, 0x0

    if-eqz v1, :cond_3

    .line 2
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->a:I

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getDalvikPrivateDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->b:I

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getDalvikPss()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->c:I

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getDalvikSharedDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->d:I

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getNativePrivateDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->e:I

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getNativePss()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->f:I

    .line 8
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getNativeSharedDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->g:I

    .line 9
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getOtherPrivateDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->h:I

    .line 10
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getOtherPss()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->i:I

    .line 11
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getOtherSharedDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->j:Ljava/lang/String;

    if-nez v1, :cond_1

    .line 12
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getMemoryStat()Ljava/lang/String;

    move-result-object v1

    if-nez v1, :cond_2

    goto :goto_0

    :cond_1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getMemoryStat()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v1, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_2

    :goto_0
    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->k:I

    .line 13
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalSwappablePss()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->l:I

    .line 14
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalSharedDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->m:I

    .line 15
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalSharedClean()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->n:I

    .line 16
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalPss()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->o:I

    .line 17
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalPrivateDirty()I

    move-result v3

    if-ne v1, v3, :cond_2

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->p:I

    .line 18
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->getTotalPrivateClean()I

    move-result p1

    if-ne v1, p1, :cond_2

    goto :goto_1

    :cond_2
    move v0, v2

    :goto_1
    return v0

    :cond_3
    return v2
.end method

.method public getDalvikPrivateDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->a:I

    return v0
.end method

.method public getDalvikPss()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->b:I

    return v0
.end method

.method public getDalvikSharedDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->c:I

    return v0
.end method

.method public getMemoryStat()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->j:Ljava/lang/String;

    return-object v0
.end method

.method public getNativePrivateDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->d:I

    return v0
.end method

.method public getNativePss()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->e:I

    return v0
.end method

.method public getNativeSharedDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->f:I

    return v0
.end method

.method public getOtherPrivateDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->g:I

    return v0
.end method

.method public getOtherPss()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->h:I

    return v0
.end method

.method public getOtherSharedDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->i:I

    return v0
.end method

.method public getTotalPrivateClean()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->p:I

    return v0
.end method

.method public getTotalPrivateDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->o:I

    return v0
.end method

.method public getTotalPss()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->n:I

    return v0
.end method

.method public getTotalSharedClean()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->m:I

    return v0
.end method

.method public getTotalSharedDirty()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->l:I

    return v0
.end method

.method public getTotalSwappablePss()I
    .locals 1

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->k:I

    return v0
.end method

.method public hashCode()I
    .locals 3

    iget v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->a:I

    const v1, 0xf4243

    xor-int/2addr v0, v1

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->b:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->c:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->d:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->e:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->f:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->g:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->h:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->i:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->j:Ljava/lang/String;

    if-nez v2, :cond_0

    const/4 v2, 0x0

    goto :goto_0

    .line 19
    :cond_0
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    :goto_0
    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->k:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->l:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->m:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->n:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v2, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->o:I

    xor-int/2addr v0, v2

    mul-int/2addr v0, v1

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->p:I

    xor-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "Memory{dalvikPrivateDirty="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->a:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", dalvikPss="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->b:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", dalvikSharedDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->c:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", nativePrivateDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->d:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", nativePss="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->e:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", nativeSharedDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->f:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", otherPrivateDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->g:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", otherPss="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->h:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", otherSharedDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->i:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", memoryStat="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->j:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalSwappablePss="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->k:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalSharedDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->l:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalSharedClean="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->m:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalPss="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->n:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalPrivateDirty="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->o:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", totalPrivateClean="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u;->p:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string/jumbo v1, "}"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
