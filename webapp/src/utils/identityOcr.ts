export interface ParsedIdentityCard {
  suspectName?: string
  gender?: string
  nation?: string
  birthDate?: string
  age?: string
  idNumber?: string
  address?: string
}

function cleanValue(value?: string | null) {
  return value?.replace(/^[：:\s]+|[：:\s]+$/g, '').trim() || ''
}

function normalizeDate(year: string, month: string, day: string) {
  const m = month.padStart(2, '0')
  const d = day.padStart(2, '0')
  return `${year}-${m}-${d}`
}

export function calculateAge(birthDate?: string) {
  if (!birthDate || !/^\d{4}-\d{2}-\d{2}$/.test(birthDate)) return ''
  const [year, month, day] = birthDate.split('-').map(Number)
  const now = new Date()
  let age = now.getFullYear() - year
  if (now.getMonth() + 1 < month || (now.getMonth() + 1 === month && now.getDate() < day)) age -= 1
  return age >= 0 && age < 130 ? String(age) : ''
}

export function parseIdentityCardOcr(raw: string): ParsedIdentityCard {
  const original = raw.replace(/\r/g, '\n').replace(/[|｜]/g, ' ')
  const flat = original.replace(/\s+/g, ' ').trim()
  const compact = original.replace(/\s+/g, '')
  const result: ParsedIdentityCard = {}

  const idMatch = compact.match(/(?:公民身份号码|身份号码|身份证号)?([0-9]{17}[0-9Xx])/)
  if (idMatch) result.idNumber = idMatch[1].toUpperCase()

  const nameMatch = flat.match(/姓名\s*[:：]?\s*([\u3400-\u9fff·]{2,20}?)(?=\s*(?:性别|民族|出生|住址|公民身份号码|身份号码|身份证号|$))/)
  if (nameMatch) result.suspectName = cleanValue(nameMatch[1])

  const genderMatch = flat.match(/性别\s*[:：]?\s*([男女])/)
  if (genderMatch) result.gender = genderMatch[1]

  const nationMatch = flat.match(/民族\s*[:：]?\s*([\u3400-\u9fff]{1,10})(?=\s*(?:出生|住址|公民身份号码|身份号码|身份证号|$))/)
  if (nationMatch) result.nation = cleanValue(nationMatch[1])

  const birthMatch = flat.match(/出生\s*[:：]?\s*(\d{4})\s*[年.\-/]\s*(\d{1,2})\s*[月.\-/]\s*(\d{1,2})\s*日?/)
    || compact.match(/出生(\d{4})(\d{2})(\d{2})/)
  if (birthMatch) result.birthDate = normalizeDate(birthMatch[1], birthMatch[2], birthMatch[3])

  if (!result.birthDate && result.idNumber) {
    const birth = result.idNumber.slice(6, 14)
    if (/^\d{8}$/.test(birth)) result.birthDate = `${birth.slice(0, 4)}-${birth.slice(4, 6)}-${birth.slice(6, 8)}`
  }

  if (!result.gender && result.idNumber) {
    const sequence = Number(result.idNumber.charAt(16))
    if (Number.isFinite(sequence)) result.gender = sequence % 2 === 1 ? '男' : '女'
  }

  const addressMatch = original.match(/住址\s*[:：]?\s*([\s\S]*?)(?=公民身份号码|身份号码|身份证号|签发机关|有效期限|$)/)
  if (addressMatch) {
    const address = addressMatch[1].replace(/\s+/g, '')
    if (address) result.address = address
  }

  result.age = calculateAge(result.birthDate)
  return result
}
