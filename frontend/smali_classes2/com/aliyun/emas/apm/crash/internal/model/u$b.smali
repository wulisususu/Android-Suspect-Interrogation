.class final Lcom/aliyun/emas/apm/crash/internal/model/u$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/u;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:I

.field private b:I

.field private c:I

.field private d:I

.field private e:I

.field private f:I

.field private g:I

.field private h:I

.field private i:I

.field private j:Ljava/lang/String;

.field private k:I

.field private l:I

.field private m:I

.field private n:I

.field private o:I

.field private p:I

.field private q:S


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;
    .locals 21

    move-object/from16 v0, p0

    iget-short v1, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    const/16 v2, 0x7fff

    if-eq v1, v2, :cond_f

    .line 2
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x1

    if-nez v2, :cond_0

    const-string v2, " dalvikPrivateDirty"

    .line 4
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_0
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x2

    if-nez v2, :cond_1

    const-string v2, " dalvikPss"

    .line 7
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_1
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x4

    if-nez v2, :cond_2

    const-string v2, " dalvikSharedDirty"

    .line 10
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_2
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x8

    if-nez v2, :cond_3

    const-string v2, " nativePrivateDirty"

    .line 13
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_3
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x10

    if-nez v2, :cond_4

    const-string v2, " nativePss"

    .line 16
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_4
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x20

    if-nez v2, :cond_5

    const-string v2, " nativeSharedDirty"

    .line 19
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_5
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit8 v2, v2, 0x40

    if-nez v2, :cond_6

    const-string v2, " otherPrivateDirty"

    .line 22
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_6
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x80

    if-nez v2, :cond_7

    const-string v2, " otherPss"

    .line 25
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_7
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x100

    if-nez v2, :cond_8

    const-string v2, " otherSharedDirty"

    .line 28
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_8
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x200

    if-nez v2, :cond_9

    const-string v2, " totalSwappablePss"

    .line 31
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_9
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x400

    if-nez v2, :cond_a

    const-string v2, " totalSharedDirty"

    .line 34
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_a
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x800

    if-nez v2, :cond_b

    const-string v2, " totalSharedClean"

    .line 37
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_b
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x1000

    if-nez v2, :cond_c

    const-string v2, " totalPss"

    .line 40
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_c
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x2000

    if-nez v2, :cond_d

    const-string v2, " totalPrivateDirty"

    .line 43
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_d
    iget-short v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    and-int/lit16 v2, v2, 0x4000

    if-nez v2, :cond_e

    const-string v2, " totalPrivateClean"

    .line 46
    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 48
    :cond_e
    new-instance v2, Ljava/lang/IllegalStateException;

    new-instance v3, Ljava/lang/StringBuilder;

    const-string v4, "Missing required properties:"

    invoke-direct {v3, v4}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v2, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 50
    :cond_f
    new-instance v1, Lcom/aliyun/emas/apm/crash/internal/model/u;

    move-object v3, v1

    iget v4, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->a:I

    iget v5, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->b:I

    iget v6, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->c:I

    iget v7, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->d:I

    iget v8, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->e:I

    iget v9, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->f:I

    iget v10, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->g:I

    iget v11, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->h:I

    iget v12, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->i:I

    iget-object v13, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->j:Ljava/lang/String;

    iget v14, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->k:I

    iget v15, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->l:I

    iget v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->m:I

    move/from16 v16, v2

    iget v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->n:I

    move/from16 v17, v2

    iget v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->o:I

    move/from16 v18, v2

    iget v2, v0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->p:I

    move/from16 v19, v2

    const/16 v20, 0x0

    invoke-direct/range {v3 .. v20}, Lcom/aliyun/emas/apm/crash/internal/model/u;-><init>(IIIIIIIIILjava/lang/String;IIIIIILcom/aliyun/emas/apm/crash/internal/model/u$a;)V

    return-object v1
.end method

.method public setDalvikPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->a:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x1

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setDalvikPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->b:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x2

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setDalvikSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->c:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x4

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setMemoryStat(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->j:Ljava/lang/String;

    return-object p0
.end method

.method public setNativePrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->d:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x8

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setNativePss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->e:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x10

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setNativeSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->f:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x20

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setOtherPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->g:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit8 p1, p1, 0x40

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setOtherPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->h:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x80

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setOtherSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->i:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x100

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setTotalPrivateClean(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->p:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x4000

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setTotalPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->o:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x2000

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setTotalPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->n:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x1000

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setTotalSharedClean(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->m:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x800

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setTotalSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->l:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x400

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method

.method public setTotalSwappablePss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;
    .locals 0

    iput p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->k:I

    iget-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    or-int/lit16 p1, p1, 0x200

    int-to-short p1, p1

    iput-short p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/u$b;->q:S

    return-object p0
.end method
